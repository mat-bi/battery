require Amnesia
use Amnesia
		

defmodule Battery do
	use Application
	use Database

	def start(_type, _args) do
		use Database
		require Amnesia
		use Amnesia
		IO.puts "Creating some new stuff"
		Amnesia.start
		Database.wait
		Amnesia.transaction do
			IO.inspect Battery.write!(%Battery{timestamp: 0, percentage: 67, status: "Charging"})
			r = %Battery{timestamp: 12, percentage: 75, status: "Discharging"} 
			IO.inspect r
			Battery.write!(r)
			%Battery{timestamp: 23, percentage: 65, status: "Charging"} |> Battery.write!
			%Battery{timestamp: 90, percentage: 12, status: "Discharging" } |> Battery.write!
		end

		IO.puts "Reading from the database"

		IO.puts "Records, where timestamp > 20"
		Amnesia.transaction do
			r = Battery.where timestamp > 20
			r |> Amnesia.Selection.values |> Enum.each &IO.inspect(&1)
		end

		IO.puts "Records, where timestamp < 20, only status and percentage"
        	Amnesia.transaction do
			r = Battery.where timestamp < 20, select: [status, percentage]
			Enum.each(Amnesia.Selection.values(r), fn(x) -> IO.inspect(x) end)
		end

		IO.puts "Record, where timestamp = 12"
		Amnesia.transaction do
			r = Battery.read(12)
			IO.inspect(r)
		end

		IO.puts "Record, where timestamp = 1"
		Amnesia.transaction do
			r = Battery.read(1)
			IO.inspect(r)
		end
		IO.puts "There isn't any :("

		#Mix.Task.run(:uninstall, [])
		Amnesia.stop

		{:ok, self()}
	end
			
end
