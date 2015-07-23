defmodule Mutter.Router do
  use Mutter.Web, :router

  socket "/ws", Mutter do
    channel "rooms:*", RoomChannel
  end

  pipeline :browser do
    plug :accepts, ["html"]
    plug :fetch_session
    plug :fetch_flash
    plug :protect_from_forgery
  end

  pipeline :api do
    plug :accepts, ["json"]
  end

  scope "/", Mutter do
    pipe_through :browser # Use the default browser stack

    get "/", PageController, :index
    get "/:channel", PageController, :channel
  end

  # Other scopes may use custom stacks.
  # scope "/api", Mutter do
  #   pipe_through :api
  # end
end
