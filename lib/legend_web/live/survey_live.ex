defmodule LegendWeb.SurveyLive do
  # alias __MODULE__.Component
  use LegendWeb, :live_view
  alias Legend.Survey
  alias Legend.Catalog
  alias LegendWeb.DemographicLive
  # alias LegendWeb.DemographicLive.Form
  alias LegendWeb.RatingLive

  def mount(_params, _session, socket) do
    {:ok, socket |> assign_demographic() |> assign_products()}
  end

  defp assign_demographic(%{assigns: %{current_user: current_user}} = socket) do
    assign(
      socket,
      :demographic,
      Survey.get_demographic_by_user(current_user)
    )
  end

  def assign_products(%{assigns: %{current_user: current_user}} = socket) do
    assign(socket, :products, list_products(current_user))
  end

  defp list_products(user) do
    Catalog.list_products_with_user_rating(user)
  end

  # handle_info genereally expect:
  # a tuple that contains the message name and payload as first argument
  # socket as second argument
  def handle_info({:created_demographic, demographic}, socket) do
    {:noreply, handle_demographic_created(socket, demographic)}
  end

  def handle_demographic_created(socket, demographic) do
    socket
    |> put_flash(:info, "Demographic successfully created")
    |> assign(:demographic, demographic)
  end
end
