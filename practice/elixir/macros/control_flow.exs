defmodule ControlFlow do
	defmacro unless(expression, do: block, else: else_block) do
		quote do
			if !unquote(expression), do: unquote(block), else: unquote(else_block)
		end
	end
end

require ControlFlow

ControlFlow.unless 5 + 2 == 7 do
	IO.puts "It works!"
else
	IO.puts "It doesn't work"
end