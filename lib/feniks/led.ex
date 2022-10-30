defmodule Feniks.LED do
  alias Circuits.GPIO
  require Logger

  def open(pin) do
    {:ok, led} = GPIO.open(pin, :output)
    Logger.debug("open #{pin}")
    led
  end

  def on(led) do
    :ok = GPIO.write(led, 1)
    led
  end

  def off(led) do
    :ok = GPIO.write(led, 0)
    led
  end
end
