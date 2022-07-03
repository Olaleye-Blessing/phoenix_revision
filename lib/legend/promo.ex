defmodule Legend.Promo do
  alias Legend.Promo.Recipient

  def change_recipient(%Recipient{} = recipient, attrs \\ %{}) do
    Recipient.changeset(recipient, attrs)
  end

  def send_promo(_recipient, _attrs) do
    #
    #
    #
    {:ok, %Recipient{}}
  end
end
