defmodule Automation.Finals.Obs do
  def get_path() do
    Application.get_env(:automation, __MODULE__)[:path]
  end

  def get_profile() do
    case Application.get_env(:automation, __MODULE__)[:profile] do
      nil -> "Untitled"
      profile -> profile
    end
  end

  def get_scene() do
    Application.get_env(:automation, __MODULE__)[:scene]
  end
end
