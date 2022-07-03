defmodule LegendWeb.PromoLive do
  use LegendWeb, :live_view
  alias Legend.Promo
  alias Legend.Promo.Recipient

  def mount(_params, _session, socket) do
    {:ok, socket |> assign_recipient() |> assign_changeset()}
  end

  def assign_recipient(socket) do
    socket |> assign(:recipient, %Recipient{})
  end

  def assign_changeset(%{assigns: %{recipient: recipient}} = socket) do
    socket |> assign(:changeset, Promo.change_recipient(recipient))
  end

  def handle_event(
        "validate",
        %{"recipient" => recipient_params},
        %{assigns: %{recipient: recipient}} = socket
      ) do
    changeset =
      recipient
      |> Promo.change_recipient(recipient_params)
      # this adds action to the changeset and signal Phoenix to display error
      |> Map.put(:action, :validate)

    {:noreply, socket |> assign(:changeset, changeset)}
  end

  # TODO: exercise
  def handle_event("save", _form_params, _socket) do
    # create and validate a changeset
    :timer.sleep(3000)
    # {:noreply, socket}
  end
end
