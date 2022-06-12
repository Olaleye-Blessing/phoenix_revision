defmodule LegendWeb.UserAuthLive do
  import Phoenix.LiveView
  alias Legend.Accounts

  def on_mount(_, params, %{"user_token" => user_token}, socket) do
    user = Accounts.get_user_by_session_token(user_token)
    socket = socket |> assign(:current_user, user)

    if user do
      {:cont, socket}
    else
      {:halt, redirect(socket, to: "/login")}
    end
  end
end
