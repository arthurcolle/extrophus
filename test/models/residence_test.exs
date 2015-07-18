defmodule Trophus.ResidenceTest do
  use Trophus.ModelCase

  alias Trophus.Residence

  @valid_attrs %{address_city: "some content", address_line_1: "some content", address_line_2: "some content", address_state: "some content", address_zip: "some content", latitude: "120.5", longitude: "120.5", name: "some content"}
  @invalid_attrs %{}

  test "changeset with valid attributes" do
    changeset = Residence.changeset(%Residence{}, @valid_attrs)
    assert changeset.valid?
  end

  test "changeset with invalid attributes" do
    changeset = Residence.changeset(%Residence{}, @invalid_attrs)
    refute changeset.valid?
  end
end
