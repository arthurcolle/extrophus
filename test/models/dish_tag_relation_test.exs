defmodule Trophus.DishTagRelationTest do
  use Trophus.ModelCase

  alias Trophus.DishTagRelation

  @valid_attrs %{}
  @invalid_attrs %{}

  test "changeset with valid attributes" do
    changeset = DishTagRelation.changeset(%DishTagRelation{}, @valid_attrs)
    assert changeset.valid?
  end

  test "changeset with invalid attributes" do
    changeset = DishTagRelation.changeset(%DishTagRelation{}, @invalid_attrs)
    refute changeset.valid?
  end
end
