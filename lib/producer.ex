defmodule HottestCity.Producer do
  use GenStage

  require Logger

  def start_link(_args) do
    GenStage.start_link(__MODULE__, [], name: __MODULE__)
  end

  def init(_args) do
    {:producer, cities()}
  end

  def handle_demand(demand, state) when demand > length(state) do
    handle_demand(demand, state ++ cities())
  end

  def handle_demand(demand, state) do
    {to_dispatch, remaining} = Enum.split(state, demand)

    {:noreply, to_dispatch, remaining}
  end

  defp cities do
    File.stream!("./priv/world_cities.csv")
      |> CSV.decode()
      |> Enum.reduce(MapSet.new(), fn {_, row}, acc ->
        [name, _, lat, lon, country | _rest] = row
        MapSet.put(acc, {name, country, lat, lon})
      end
    )
  end
end
