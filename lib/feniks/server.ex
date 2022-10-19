defmodule Feniks.Server do
  alias Feniks.LED
  defstruct [:led, :on, :timeout]
  use GenServer

  def new(opts) do
    %__MODULE__{
      on: false,
      led: LED.open(opts[:pin]),
      timeout: opts[:timeout] || 1000
    }
  end

  def start_link(opts) do
    {:ok, _pid} = GenServer.start_link(__MODULE__, opts)
  end

  def init(opts) do
    send(self(), :blink)
    {:ok, new(opts)}
  end

  def wait(timeout) do
    Process.send_after(self(), :blink, timeout)
  end
  
  def handle_info(:blink, blinker) do
    wait(blinker.timeout)
    {:noreply, blink(blinker)}
  end

  defp blink(%{on: true} = blinker) do
    LED.on(blinker.led)
    %{blinker| on: false}
  end
  defp blink(%{on: false} = blinker) do
    LED.off(blinker.led)
    %{blinker| on: true}
  end
end
