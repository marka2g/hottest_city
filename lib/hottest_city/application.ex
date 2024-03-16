defmodule HottestCity.Application do
  @moduledoc false

  use Application

  alias HottestCity.{Producer, Processor, TemperatureAgent}

  def start(_type, _args) do
    children = [
      TemperatureAgent,
      Producer,
      Processor
    ]

    opts = [strategy: :one_for_one, name: HottestCity.Supervisor]
    Supervisor.start_link(children, opts)
  end
end
