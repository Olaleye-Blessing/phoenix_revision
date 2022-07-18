defmodule LegendWeb.Admin.DashboardLive do
  use LegendWeb, :live_view

  def mount(_params, _session, socket) do
    {:ok,
     socket
     |> assign(:survey_results_component_id, "survey-results")}
  end
end
