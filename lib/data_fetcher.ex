defmodule HottestCity.DataFetcher do
  require Logger

  @open_weather_api_key System.fetch_env!("OPEN_WEATHER_API_KEY")

  def fetch(city_data) do
    city_data
    |> build_url()
    |> HTTPoison.get()
    |> handle_response()
  end

  defp build_url({_, _, lat, lon} = _city_data) do
    "https://api.openweathermap.org/data/2.5/weather?lat=#{lat}&lon=#{lon}&appid=#{@open_weather_api_key}"
  end

  defp handle_response({:ok, %HTTPoison.Response{status_code: 200, body: body}}) do
    body
    |> Jason.decode!()
    |> get_in(["main", "temp"])
  end

  defp handle_response(resp) do
    Logger.warning("Failed to fetch temperature data: #{inspect(resp)}")

    :error
  end
end
