defmodule LegendWeb.SurveyLive do
  # alias __MODULE__.Component
  use LegendWeb, :live_view
  alias Legend.Survey
  alias LegendWeb.DemographicLive

  def mount(_params, _session, socket) do
    {:ok, socket |> assign_demographic}
  end

  defp assign_demographic(%{assigns: %{current_user: current_user}} = socket) do
    assign(
      socket,
      :demographic,
      Survey.get_demographic_by_user(current_user)
    )
  end
end
