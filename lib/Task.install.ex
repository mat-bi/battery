defmodule Mix.Tasks.Install do
  use Mix.Task
  use Database

  def run(_) do
    IO.inspect Amnesia.Schema.create
    IO.inspect Amnesia.start    
    IO.inspect Database.create(disk: [node])
    # Database.create(ram: [node])
    IO.inspect Database.wait
    IO.inspect Amnesia.stop
  end
end
