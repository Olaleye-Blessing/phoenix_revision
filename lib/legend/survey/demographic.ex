defmodule Legend.Survey.Demographic do
  use Ecto.Schema
  import Ecto.Changeset

  alias Legend.Accounts.User

  schema "demographics" do
    field :gender, :string
    field :year_of_birth, :integer
    # field :user_id, :id
    belongs_to :user, User

    timestamps()
  end

  @doc false
  def changeset(demographic, attrs) do
    demographic
    |> cast(attrs, [:gender, :year_of_birth, :user_id])
    |> validate_required([:gender, :year_of_birth, :user_id])
    |> validate_inclusion(:gender, ["male", "female", "other", "prefer not to say"])
    |> validate_inclusion(:year_of_birth, 1990..2022)
    |> unique_constraint(:user_id)
  end
end
