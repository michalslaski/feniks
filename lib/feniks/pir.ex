defmodule Feniks.PIR do
  use GenServer
  alias Circuits.GPIO
  require Logger

  @pin 17

  def start_link() do
    GenServer.start_link(__MODULE__, nil, name: __MODULE__)
  end

  @impl true
  def init(nil) do
    {:ok, [], {:continue, :init_sensor}}
  end

  @impl true
  def handle_continue(:init_sensor, _state) do
    {:ok, gpio} = GPIO.open(@pin, :input)
    Logger.info("PIR init_sensor")
    result = GPIO.set_interrupts(gpio, :both)
    Logger.info(Kernel.inspect(result))
    {:noreply, [gpio: gpio]}
  end

  @impl true
  def handle_info({:circuits_gpio, @pin, _, 1}, state) do
    Logger.info("got 1 on pin #{@pin}")

    sound_file =
      Path.wildcard("/srv/erlang/static/*")
      |> Enum.random()
      |> String.to_charlist()

    result = :os.cmd('aplay -q ' ++ sound_file)
    Logger.info(Kernel.inspect(result))

    {:noreply, state}
  end

  def handle_info({:circuits_gpio, @pin, _, 0}, state) do
    {:noreply, state}
  end
end
