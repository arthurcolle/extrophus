defmodule HelloPhoenix.DishTest do
  use HelloPhoenix.ModelCase

  alias HelloPhoenix.Dish

  @valid_attrs %{description: "some content", name: "some content", price: 42}
  @invalid_attrs %{}

  test "changeset with valid attributes" do
    changeset = Dish.changeset(%Dish{}, @valid_attrs)
    assert changeset.valid?
  end

  test "changeset with invalid attributes" do
    changeset = Dish.changeset(%Dish{}, @invalid_attrs)
    refute changeset.valid?
  end
end
