defmodule ControlFlow do
	defmacro unless(expression, do: block, else: else_block) do
		quote do
			if !unquote(expression), do: unquote(block), else: unquote(else_block)
		end
	end

	defmacro if(expression, do: block, else: else_block) do
		quote do
			case unquote(expression) do
				false -> unquote(else_block)
				nil -> unquote(else_block)
				_ -> unquote(block)
			end
		end
	end
end

require ControlFlow

ControlFlow.if 5 + 2 == 6 do
	IO.puts "It works!"
else
	IO.puts "It doesn't work"
end

ControlFlow.unless 5 + 2 == 7 do
	IO.puts "It works!"
else
	IO.puts "It doesn't work"
end