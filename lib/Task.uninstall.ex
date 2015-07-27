defmodule Mix.Tasks.Uninstall do
  use Mix.Task
  use Database

  def run(_) do

    Amnesia.start
    Database.destroy
    Amnesia.stop
    Amnesia.Schema.destroy
    File.rm_rf("Mnesia.nonode@nohost")

  end
end
