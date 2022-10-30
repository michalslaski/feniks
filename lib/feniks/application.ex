defmodule Feniks.Application do
  # See https://hexdocs.pm/elixir/Application.html
  # for more information on OTP Applications
  @moduledoc false

  use Application

  @pin1 14
  @pin2 15
  @pin3 16
  @pin4 18
  @pin5 20
  @pin6 21

  @impl true
  def start(_type, _args) do
    {:ok, _pid} = Feniks.Supervisor.start_link()
    # {:ok, _pid} = Feniks.DynamicSupervisor.start_link()
    # Feniks.DynamicSupervisor.start_child([pin: @pin1, timeout: 1000])
    # Feniks.DynamicSupervisor.start_child([pin: @pin2, timeout: 800])
    # Feniks.DynamicSupervisor.start_child([pin: @pin3, timeout: 600])
    # Feniks.DynamicSupervisor.start_child([pin: @pin4, timeout: 500])
    # Feniks.DynamicSupervisor.start_child([pin: @pin5, timeout: 1200])
    # Feniks.DynamicSupervisor.start_child([pin: @pin6, timeout: 700])
  end
end
