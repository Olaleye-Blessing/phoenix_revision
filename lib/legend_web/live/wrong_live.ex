defmodule LegendWeb.WrongLive do
  use Phoenix.LiveView, layout: {LegendWeb.LayoutView, "live.html"}

  # establish initial state
  def mount(_params, _session, socket) do
    {:ok, assign(socket, score: 0, message: "Make a guess")}
  end

  def render(assigns) do
    ~H"""
    <h1>Your score: <%= @score %></h1>
    <h2>
      <%= @message %>
    </h2>
    <p>It's <%= time() %></p>
    <div>
      <%= for n <- 1..10 do %>
        <a href="#" phx-click="guess" phx-value-number={n}>
          <%= n %>
        </a>
      <% end %>
    </div>
    """
  end

  def handle_event("guess", data, socket) do
    %{"number" => guess} = data
    message = "Your guess: #{guess} is wrong. Guess again. "
    score = socket.assigns.score - 1

    # return tuple in the shape that liveview expects -- {:noreply, socket}
    {
      :noreply,
      assign(
        socket,
        message: message,
        score: score
      )
    }
  end

  def time() do
    DateTime.utc_now() |> to_string
  end
end
