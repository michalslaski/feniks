defmodule Feniks.Button do
  use GenServer
  alias Circuits.GPIO
  require Logger

  @pin 27

  def start_link() do
    GenServer.start_link(__MODULE__, nil, name: __MODULE__)
  end

  @impl true
  def init(nil) do
    {:ok, 0, {:continue, :init_sensor}}
  end

  @impl true
  def handle_continue(:init_sensor, state) do
    {:ok, gpio} = GPIO.open(@pin, :input)
    Logger.info("Button init_sensor")

    :ok = GPIO.set_pull_mode(gpio, :pullup)
    # Pushing the button will result in 0
    result = GPIO.set_interrupts(gpio, :falling)
    Logger.info(Kernel.inspect(result))

    {:noreply, state}
  end

  @impl true
  def handle_info(event = {:circuits_gpio, @pin, timestamp, _}, state)
      when timestamp > state + 2_000_000_000 do
    Logger.info("Button got #{Kernel.inspect(event)}")

    sound_file =
      Path.wildcard("/srv/erlang/static/*")
      |> Enum.random()
      |> String.to_charlist()

    result = :os.cmd('aplay -q ' ++ sound_file)
    Logger.info(Kernel.inspect(result))

    {:noreply, timestamp}
  end

  def handle_info({:circuits_gpio, _, _, _}, state) do
    {:noreply, state}
  end
end
