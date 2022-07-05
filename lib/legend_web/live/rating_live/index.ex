defmodule LegendWeb.RatingLive.Index do
  use Phoenix.Component
  use Phoenix.HTML

  alias LegendWeb.RatingLive

  def products(assigns) do
    ~H"""
      <div class="survey-component-container">
        <.heading products={@products} />
        <.list products={@products} current_user={@current_user} />
      </div>
    """
  end

  def heading(assigns) do
    ~H"""
      <h2>
        Ratings <%= if ratings_complete?(@products), do: raw "&#x2713;" %>
      </h2>
    """
  end

  def list(assigns) do
    ~H"""
      <%= for {product, index} <- Enum.with_index(@products) do %>
        <%= if rating = List.first(product.ratings) do %>
          <RatingLive.Show.stars rating={rating} product={product} />
        <% else %>
          <.live_component module={RatingLive.Form}
            id={"rating-form-#{product.id}"}
            product={product}
            product_index={index}
            current_user={@current_user}
          />
        <% end %>
      <% end %>
    """
  end

  defp ratings_complete?(products) do
    Enum.all?(products, fn product ->
      length(product.ratings) == 1
    end)
  end

  def handle_info({:created_rating, updated_product, product_index}, socket) do
    {:noreply, handle_rating_created(socket, updated_product, product_index)}
  end

  def handle_rating_created(
        %{assigns: %{products: products}} = socket,
        updated_product,
        product_index
      ) do
    socket
    |> put_flash(:info, "Rating submitted successfully")
    |> assign(
      :products,
      List.replace_at(products, product_index, updated_product)
    )
  end
end
