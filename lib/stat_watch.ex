defmodule StatWatch do
  def column_names() do
    Enum.join(~w(DateTime Subscribers Videos Views), ",")
  end

  def fetch_stats() do
    now = DateTime.to_string(%{DateTime.utc_now() | microsecond: {0, 0}})

    %{body: body} = HTTPoison.get!(stats_url())

    %{items: [%{statistics: stats} | _]} =
      Poison.decode!(body,
        keys: :atoms
      )

    [
      now,
      stats.subscriberCount,
      stats.videoCount,
      stats.viewCount
    ]
    |> Enum.join(", ")
  end

  def stats_url do
    youtube_api_v3 = "https://www.googleapis.com/youtube/v3/"
    channel = "id=" <> "UCThRUP0dBolJaHFoSoq07ZA"
    key = "key=" <> "AIzaSyANaUj0ClHpbPdmpvMJ6OyGCkbGmP7X-pY"
    "#{youtube_api_v3}channels?#{channel}&#{key}&part=statistics"
  end
end
