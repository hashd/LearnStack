defmodule Mutter.RoomChannel do
  use Phoenix.Channel

  def join("rooms:" <> _channel_name, _msg, socket) do
    {:ok, socket}
  end

  def terminate(_reason, socket) do
    user_list = Dict.get(socket.assigns, :users)
    IO.inspect(user_list)
    {:noreply, socket}
  end

  def handle_in("new:user", msg, socket) do
    users = if Phoenix.Socket.get_assign(socket, :users) === nil do 
      [msg["user"]]
    else 
      [msg["user"] | Phoenix.Socket.get_assign(socket, :users)]
    end
    Phoenix.Socket.assign(socket, :users, users)

    broadcast! socket, "current:users", %{users: Phoenix.Socket.get_assign(socket, :users)}
    broadcast! socket, "new:user", %{user: msg["user"]}
    {:noreply, socket}
  end

  def handle_in("new:message", msg, socket) do
    broadcast! socket, "new:message", %{user: msg["user"], body: msg["body"]}
    {:noreply, socket}
  end
end