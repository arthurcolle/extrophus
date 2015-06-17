defmodule Trophus.DishController do
  use Trophus.Web, :controller

  alias Trophus.Dish

  plug :scrub_params, "dish" when action in [:create, :update]
  plug :find_user
  plug :action



  
  def new(conn, _params) do
    changeset = Dish.changeset(%Dish{})
    render conn, changeset: changeset
  end

  def create(conn, %{"dish" => dish_params}) do
    changeset = 
      build(conn.assigns.user, :dishes)
      |> Dish.changeset(dish_params)

    if changeset.valid? do
      Repo.insert(changeset)

      conn
      |> put_flash(:info, "Dish created successfully.")
      |> redirect(to: user_dish_path(conn, :index, conn.assigns.user))
    else
      render(conn, "new.html", changeset: changeset)
    end
  end

  def show(conn, %{"id" => id}) do
    dish = Repo.get(Dish, id)
    render(conn, "show.html", dish: dish)
  end

  def edit(conn, %{"id" => id}) do
    dish = Repo.get(Dish, id)
    changeset = Dish.changeset(dish)
    render(conn, "edit.html", dish: dish, changeset: changeset)
  end

  def update(conn, %{"id" => id, "dish" => dish_params}) do
    dish = Repo.get(Dish, id)
    changeset = Dish.changeset(dish, dish_params)

    if changeset.valid? do
      Repo.update(changeset)

      conn
      |> put_flash(:info, "Dish updated successfully.")
      |> redirect(to: user_dish_path(conn, :index, conn.assigns.user))
    else
      render(conn, "edit.html", dish: dish, changeset: changeset)
    end
  end

  def delete(conn, %{"id" => id}) do
    dish = Repo.get(Dish, id)
    Repo.delete(dish)

    conn
    |> put_flash(:info, "Dish deleted successfully.")
    |> redirect(to: user_dish_path(conn, :index, conn.assigns.user))
  end
  
  defp find_user(conn, _) do
    user = Repo.get(Trophus.User, conn.params["user_id"])
    IO.inspect user
    assign(conn, :user, user)
  end

  def index(conn, _params) do
    user = conn.assigns.user
    dishes = Repo.all assoc(user, :dishes)
    render conn, dishes: dishes, user: user
  end

end
