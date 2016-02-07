defmodule Trophus.OrderItemTest do
  use Trophus.ModelCase

  alias Trophus.OrderItem

  @valid_attrs %{dish: nil, order: nil, quantity: 42, total_price: 42, unit_price: 42}
  @invalid_attrs %{}

  test "changeset with valid attributes" do
    changeset = OrderItem.changeset(%OrderItem{}, @valid_attrs)
    assert changeset.valid?
  end

  test "changeset with invalid attributes" do
    changeset = OrderItem.changeset(%OrderItem{}, @invalid_attrs)
    refute changeset.valid?
  end
end
