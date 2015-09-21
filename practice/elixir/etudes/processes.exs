defmodule GreeterServer do
  def greet(count \\ 1) do
    receive do
      {:welcome, name} -> IO.inspect "Hello #{name}"
      {:gift, item} -> IO.inspect "Thanks for #{item}"
      {:bye, name} -> IO.inspect "It was nice meeting you, #{name}"
    end
    greet(count+1)
  end
end

spawn_link(GreeterServer, :greet, []) |> Process.register(:greeter)

send(:greeter, {:welcome, "hashd"})
send(:greeter, {:gift, "pen"})
send(:greeter, {:bye, "hashd"})

:greeter |> Process.whereis |> Process.info