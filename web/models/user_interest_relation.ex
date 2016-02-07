defmodule Trophus.UserInterestRelation do
  use Trophus.Web, :model

  schema "user_interest_relations" do
    belongs_to :user, Trophus.User, foreign_key: :user_id
    belongs_to :interest, Trophus.Interest, foreign_key: :interest_id
    timestamps
  end

  @required_fields ~w(user_id interest_id)
  @optional_fields ~w()

  @doc """
  Creates a changeset based on the `model` and `params`.

  If no params are provided, an invalid changeset is returned
  with no validation performed.
  """
  def changeset(model, params \\ :empty) do
    model
    |> cast(params, @required_fields, @optional_fields)
  end
end
