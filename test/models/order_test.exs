defmodule Trophus.OrderTest do
  use Trophus.ModelCase

  alias Trophus.Order

  @valid_attrs %{complete: true, shipping: 42, subtotal: 42, tax: 42, total: 42}
  @invalid_attrs %{}

  test "changeset with valid attributes" do
    changeset = Order.changeset(%Order{}, @valid_attrs)
    assert changeset.valid?
  end

  test "changeset with invalid attributes" do
    changeset = Order.changeset(%Order{}, @invalid_attrs)
    refute changeset.valid?
  end
end
