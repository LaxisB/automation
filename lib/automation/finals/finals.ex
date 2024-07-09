defmodule Automation.Finals do
  alias Automation.Finals.Obs

  defstruct obs_port: nil, breaker_blown: false

  use GenServer

  @moduledoc """
  Start OBS if "the FINALS" is running
  """

  def start_link(_) do
    GenServer.start_link(__MODULE__, nil, name: __MODULE__)
  end

  @impl GenServer
  def init(nil) do
    Process.send_after(self(), :check, 1000)
    {:ok, %__MODULE__{}}
  end

  defp handle_finals(%__MODULE__{breaker_blown: true} = state) do
    IO.puts("Found Finals and OBS is not running, but the breaker is blown")
    {:noreply, state}
  end

  defp handle_finals(%__MODULE__{obs_port: nil} = state) do
    IO.puts("Found Finals and OBS is not running")

    path = Obs.get_path()

    obs_port =
      Port.open({:spawn_executable, path <> "\\bin\\64bit\\obs64.exe"}, [
        :binary,
        :exit_status,
        cd: path <> "\\bin\\64bit",
        args: [
          "-m",
          "--profile",
          Obs.get_profile(),
          "--scene",
          Obs.get_scene(),
          "--startreplaybuffer"
        ]
      ])

    %__MODULE__{state | obs_port: obs_port}
  end

  defp handle_finals(_state) do
  end

  defp handle_nofinals(_state) do
    # todo: stop replay buffer and gracefully stop obs
  end

  @impl GenServer
  def handle_info(:check, state) do
    # check if the process is running
    # if not, restart it
    # if it is, do nothing
    # then schedule the next check
    Process.send_after(self(), :check, 10_000)

    with false <- Automation.Os.process_exists?("obs64.exe"),
         finals_running <- Automation.Os.process_exists?("Discovery.exe") do
      case finals_running do
        true -> {:noreply, handle_finals(state)}
        false -> {:noreply, handle_nofinals(state)}
      end
    else
      # we don't care if we shouldn't / can't start OBS
      _ ->
        {:noreply, state}
    end
  end

  def handle_info({_port, {:data, msg}}, state) do
    IO.puts("[OBS] #{msg}")
    {:noreply, state}
  end

  def handle_info({_port, {:exit_status, status}}, state) do
    IO.puts("[OBS] exited with status: #{status}")
    {:noreply, %__MODULE__{state | obs_port: nil, breaker_blown: true}}
  end
end
