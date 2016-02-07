defmodule Trophus.DishTagRelation do
  use Trophus.Web, :model

  schema "dish_tag_relations" do
    belongs_to :dish, Trophus.Dish, foreign_key: :dish_id
    belongs_to :tag, Trophus.Tag, foreign_key: :tag_id
    timestamps
  end

  @required_fields ~w(dish_id tag_id)
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
