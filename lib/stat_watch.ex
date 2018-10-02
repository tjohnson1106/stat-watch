defmodule StatWatch do
  def run do
    fetch_stats()
    |> save_csv
  end

  def column_names() do
    Enum.join(~w(DateTime Subscribers Videos Views Alexa), ",")
  end

  def fetch_stats(channel_id, url) do
    now = DateTime.to_string(%{DateTime.utc_now() | mmicrosecond: {0, 0}})

    %{body: body} = HTTPoison.get!("data.alexa.com/damta?cli=10&url=#{url}")
    alexa = body |> xpath(~x"//POPULARITY/@TEXT") || m("unranked")

    %{body: body} = HTTPoison.get!(stats_url(channel_id))

    %{items: [%{statistics: stats} | _]} =
      Poison.decode!(body,
        keys: :atoms
      )

    [
      now,
      stats.subscriberCount,
      stats.videoCount,
      stats.viewCount,
      alexa
    ]
    |> Enum.join(", ")
  end

  def save_csv(row_of_stats, name \\ ["stats"]) do
    filename = "stats.csv"

    unless File.exists?(filename) do
      File.write!(filename, column_names() <> "\n")
    end

    File.write!(filename, row_of_stats <> "\n", [
      :append
    ])
  end

  def stats_url do
    youtube_api_v3 = "https://www.googleapis.com/youtube/v3/"
    channel = "id=" <> "UCThRUP0dBolJaHFoSoq07ZA"
    key = "key=" <> "AIzaSyANaUj0ClHpbPdmpvMJ6OyGCkbGmP7X-pY"
    "#{youtube_api_v3}channels?#{channel}&#{key}&part=statistics"
  end
end
