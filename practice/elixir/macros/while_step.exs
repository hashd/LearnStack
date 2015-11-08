defmodule Loop do
	defmacro while(expression, do: block) do
		quote do
			try do
				for _ <- Stream.cycle([:ok]) do
					if unquote(expression) do
						unquote(block)
					else
						Loop.break
					end
				end
			catch
				:break -> :ok
			end
		end
	end

	def break, do: throw :break
end

import Loop
run_loop = fn ->
	pid = spawn(fn -> :timer.sleep(1000) end)
	while Process.alive?(pid) do
		IO.puts "Process is up and running!"
		:timer.sleep 100
	end
end

pid = spawn fn ->
	while true do
		receive do
			:stop ->
				IO.puts "Stopping...."
				break
			message ->
				IO.puts "Got message #{inspect message}"
		end
	end
end