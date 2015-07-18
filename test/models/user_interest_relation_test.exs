defmodule Trophus.UserInterestRelationTest do
  use Trophus.ModelCase

  alias Trophus.UserInterestRelation

  @valid_attrs %{}
  @invalid_attrs %{}

  test "changeset with valid attributes" do
    changeset = UserInterestRelation.changeset(%UserInterestRelation{}, @valid_attrs)
    assert changeset.valid?
  end

  test "changeset with invalid attributes" do
    changeset = UserInterestRelation.changeset(%UserInterestRelation{}, @invalid_attrs)
    refute changeset.valid?
  end
end
