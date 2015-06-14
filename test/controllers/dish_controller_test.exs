defmodule HelloPhoenix.DishControllerTest do
  use HelloPhoenix.ConnCase

  alias HelloPhoenix.Dish
  @valid_attrs %{description: "some content", name: "some content", price: 42}
  @invalid_attrs %{}

  setup do
    conn = conn()
    {:ok, conn: conn}
  end

  test "lists all entries on index", %{conn: conn} do
    conn = get conn, dish_path(conn, :index)
    assert html_response(conn, 200) =~ "Listing dishes"
  end

  test "renders form for new resources", %{conn: conn} do
    conn = get conn, dish_path(conn, :new)
    assert html_response(conn, 200) =~ "New dish"
  end

  test "creates resource and redirects when data is valid", %{conn: conn} do
    conn = post conn, dish_path(conn, :create), dish: @valid_attrs
    assert redirected_to(conn) == dish_path(conn, :index)
    assert Repo.get_by(Dish, @valid_attrs)
  end

  test "does not create resource and renders errors when data is invalid", %{conn: conn} do
    conn = post conn, dish_path(conn, :create), dish: @invalid_attrs
    assert html_response(conn, 200) =~ "New dish"
  end

  test "shows chosen resource", %{conn: conn} do
    dish = Repo.insert %Dish{}
    conn = get conn, dish_path(conn, :show, dish)
    assert html_response(conn, 200) =~ "Show dish"
  end

  test "renders form for editing chosen resource", %{conn: conn} do
    dish = Repo.insert %Dish{}
    conn = get conn, dish_path(conn, :edit, dish)
    assert html_response(conn, 200) =~ "Edit dish"
  end

  test "updates chosen resource and redirects when data is valid", %{conn: conn} do
    dish = Repo.insert %Dish{}
    conn = put conn, dish_path(conn, :update, dish), dish: @valid_attrs
    assert redirected_to(conn) == dish_path(conn, :index)
    assert Repo.get_by(Dish, @valid_attrs)
  end

  test "does not update chosen resource and renders errors when data is invalid", %{conn: conn} do
    dish = Repo.insert %Dish{}
    conn = put conn, dish_path(conn, :update, dish), dish: @invalid_attrs
    assert html_response(conn, 200) =~ "Edit dish"
  end

  test "deletes chosen resource", %{conn: conn} do
    dish = Repo.insert %Dish{}
    conn = delete conn, dish_path(conn, :delete, dish)
    assert redirected_to(conn) == dish_path(conn, :index)
    refute Repo.get(Dish, dish.id)
  end
end
