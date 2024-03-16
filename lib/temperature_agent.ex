defmodule HottestCity.TemperatureAgent do
  use Agent

  def start_link(_) do
    Agent.start_link(fn -> nil end, name: __MODULE__)
  end

  def get_temp do
    Agent.get(__MODULE__, fn {city, country, temp} ->
      "Currently, the hottest city on earth is #{city}, #{country} with a temperature of #{to_fahrenheit(temp)}°F"
    end)
  end

  def update_temp(:error), do: nil

  def update_temp({_, _, new_temp} = new_data) do
    Agent.update(__MODULE__, fn
      {_, _, orig_temp} = orig_data ->
        if new_temp > orig_temp, do: new_data, else: orig_data

      nil ->
        new_data
    end)
  end

  defp to_fahrenheit(temp), do: (temp - 273.15) * 9/5 + 32
  
end
