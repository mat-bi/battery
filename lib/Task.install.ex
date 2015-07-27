defmodule Mix.Tasks.Install do
  use Mix.Task
  use Database

  def run(_) do
	Amnesia.Schema.create
	Amnesia.start    
	Database.create(disk: [node])
    # Database.create(ram: [node])
	Database.wait
	Amnesia.stop
  end
end
