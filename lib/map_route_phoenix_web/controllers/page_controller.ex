defmodule MapRoutePhoenixWeb.PageController do
  use MapRoutePhoenixWeb, :controller

  def index(conn, _params) do
    render conn, "index.html"
  end
end
