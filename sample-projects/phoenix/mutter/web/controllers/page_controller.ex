defmodule Mutter.PageController do
  use Mutter.Web, :controller

  def index(conn, _params) do
    render conn, "index.html"
  end
end
