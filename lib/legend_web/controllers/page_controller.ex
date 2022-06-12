defmodule LegendWeb.PageController do
  use LegendWeb, :controller

  def index(conn, _params) do
    redirect(conn, to: "/guess")
    # render(conn, "index.html")
  end
end
