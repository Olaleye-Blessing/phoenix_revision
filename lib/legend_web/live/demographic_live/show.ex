defmodule LegendWeb.DemographicLive.Show do
  use Phoenix.Component
  # helps to render unicode character
  use Phoenix.HTML

  def details(assigns) do
    ~H"""
    <div class="survey-component-container">
      <h2>Demographics <%= raw "&#x2713;" %></h2>
      <ul>
        <li>Gender: <%= @demographic.gender %></li>
        <li>Year of birth: <%= @demographic.year_of_birth %></li>
      </ul>
    </div>
    """
  end
end
