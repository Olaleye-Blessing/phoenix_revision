defmodule LegendWeb.PageController do
  use LegendWeb, :controller

  def index(conn, _params) do
    render(conn, "index.html")
  end
end
