defmodule Ticker do
  @interval 2000
  @name :ticker

  def start do
    pid = spawn(__MODULE__, :generator, [[]])
    :global.register_name(:ticker, pid)
  end

  def register(client_pid) do
    send :global.whereis_name(@name), {:register, client_pid}
  end

  def generator(clients) do
    receive do
      {:register, client_pid} ->
        IO.puts "Registering new client"
        generator([client_pid | clients])
    after
      @interval ->
        IO.puts "tick"
        Enum.each(clients, fn client ->
          send client, {:tick}
        end)
        generator(clients)
    end
  end
end

defmodule Client do
  def start do
    spawn(Client, :receiver, [])
    |> Ticker.register
  end

  def receiver do
    receive do
      {:tick} ->
        IO.puts "Tock in client"
        receiver
    end
  end
end