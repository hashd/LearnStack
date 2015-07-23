defmodule Mutter.PageController do
  use Mutter.Web, :controller

  def index(conn, _params) do
    render conn, "index.html"
  end

  def channel(conn, params) do
    render conn, "index.html", channel: params["channel"]
  end
end
