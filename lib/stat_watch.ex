defmodule StatWatch do
  def column_names() do
    Enum.join(~w(DateTime Subscribers Videos Views), ",")
  end

  def stat_url do
    youtube_api_v3 = "https://www.googleapis.com/youtube/v3/"
    channel = "id=" <> "UCThRUP0dBolJaHFoSoq07ZA"
    key = "key=" <> "AIzaSyANaUj0ClHpbPdmpvMJ6OyGCkbGmP7X-pY"
    "#{youtube_api_v3}channels?#{channel}&#{key}&part=statistics"
  end
end
