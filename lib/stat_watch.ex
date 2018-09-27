defmodule StatWatch do
  def stat_url do
    youtube_api_v3 = "https://developers.google.com/youtube/v3"
    channel = "id=" <> "UCThRUP0dBolJaHFoSoq07ZA"
    key = "key=" <> "AIzaSyDjR38yUhrzECXZ8jCsxM_AB-raYh82eUE"
    "#{youtube_api_v3}channels?#{channel}&#{key}&part=statistics"
  end
end
