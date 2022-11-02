defmodule Feniks.Supervisor do
  use Supervisor

  def start_link() do
    {:ok, _pid} = Supervisor.start_link(__MODULE__, :ok, name: __MODULE__)
  end

  @impl true
  def init(:ok) do
    children = [
      %{id: Button, start: {Feniks.Button, :start_link, []}},
      %{id: PIR, start: {Feniks.PIR, :start_link, []}},
      %{id: DynamicSupervisor, start: {Feniks.DynamicSupervisor, :start_link, []}}
    ]

    Supervisor.init(children, strategy: :one_for_one)
  end
end
