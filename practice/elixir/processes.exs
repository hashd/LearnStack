defmodule Spawn do
  def greet do
    receive do
      {sender, message} ->
        send sender, {:ok, "Hello, #{message}"}
        greet()
    end
  end
end

pid = spawn(Spawn, :greet, [])
send pid, { self, "World!"}
send pid, { self, "World!"}
send pid, { self, "World!"}
send pid, { self, "World!"}

receive do
  {:ok, message} -> message
  after 500 -> IO.puts "Actor has gone away" 
end

receive do
  {:ok, message} -> message
  after 500 -> IO.puts "Actor has gone away" 
end