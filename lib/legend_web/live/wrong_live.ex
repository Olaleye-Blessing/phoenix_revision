defmodule LegendWeb.WrongLive do
  use Phoenix.LiveView, layout: {LegendWeb.LayoutView, "live.html"}
  @max_random 20
  @max_trial 5

  # establish initial state
  def mount(_params, _session, socket) do
    {:ok,
     assign(socket,
       score: 0,
       message: "Make a guess between 0 and #{@max_random} inclusive",
       guess_message: "",
       max_rand: @max_random,
       random_num: createRandom(),
       trial: @max_trial,
       restart: false,
       date: time()
     )}
  end

  def render(assigns) do
    ~H"""
    <h1>Guess Game</h1>
    <div>
      <p>Trial left: <%= @trial %></p>
      <p>Your score: <%= @score %></p>
    </div>
    <p><%= @message %></p>
    <div>
      <%= if @trial > 0 && @guess_message != "You guessed right" do %>
        <%= for n <- 1..@max_rand do %>
          <a href="#" phx-click="guess" phx-value-number={n}>
            <%= n %>
          </a>
        <% end %>
      <% end %>
    </div>
    <pre><%= @guess_message %></pre>

    <%= if @restart == true do %>
      <button phx-click="restart">Restart</button>
    <% end %>
    <p>It's <%= @date %></p>
    """
  end

  def handle_event("restart", _data, socket) do
    # %{score: score} = socket.assigns

    {:ok,
     assign(socket,
       guess_message: "",
       random_num: createRandom(),
       trial: @max_trial,
       restart: false,
       date: time()
     )}
  end

  def handle_event("guess", data, socket) do
    %{"number" => guess} = data
    %{random_num: secret_num, score: cur_score, trial: trial} = socket.assigns

    trial =
      if trial == 0 do
        trial
      else
        trial - 1
      end

    guess = String.to_integer(guess)

    {guess_msg, score, restart} =
      if trial === 0 do
        {"No more trials. Secret number is: #{secret_num}", cur_score - 1, true}
      else
        cond do
          guess == secret_num -> {"You guessed right", cur_score + 1, true}
          guess < secret_num -> {"#{guess} is Less than secret number", cur_score, false}
          guess > secret_num -> {"#{guess} is greater than secret number", cur_score, false}
        end
      end

    # return tuple in the shape that liveview expects -- {:noreply, socket}
    {
      :noreply,
      assign(
        socket,
        score: score,
        guess_message: guess_msg,
        trial: trial,
        restart: restart
      )
    }
  end

  def time() do
    DateTime.utc_now() |> to_string
  end

  def createRandom(), do: :rand.uniform(@max_random + 1)
end
