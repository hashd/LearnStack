defmodule Assertion do
  defmacro extend(options \\ []) do
    quote do
      import unquote(__MODULE__)

      def run do
        IO.puts "Running tests ..."
      end

      def proxy_run do
        IO.puts "Calling run from within another injected function"
        run
      end
    end
  end
end

defmodule MathTest do
  require Assertion

  Assertion.extend
end