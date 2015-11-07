defmodule Setter do
	defmacro bind_name(string) do
		quote do
			name = unquote(string)
		end
	end
end

defmodule UnsafeSetter do
	defmacro bind_name(string) do
		quote do
			var!(name) = unquote(string)
		end
	end
end

require Setter
require UnsafeSetter

name = "Chris"
Setter.bind_name "Max"
name

UnsafeSetter.bind_name "Max"
name