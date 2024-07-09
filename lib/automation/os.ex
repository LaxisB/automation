defmodule Automation.Os do
  @moduledoc """
  OS specific functions
  """

  @doc """
  check if a process with the given name is running
  """
  def process_exists?(name) do
    case :os.type() do
      {:win32, _} -> process_exists_windows(name)
      _ -> process_exists_unix(name)
    end
  end

  defp process_exists_unix(name) do
    case System.cmd("pgrep", [name]) do
      {_, 0} -> true
      _ -> false
    end
  end

  defp process_exists_windows(name) do
    case System.cmd("tasklist", []) do
      {output, 0} -> String.contains?(output, name)
      _ -> false
    end
  end
end
