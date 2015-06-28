defmodule Trophus.DishController do
  require ErlasticSearch
  

  use Trophus.Web, :controller

  alias Trophus.Dish

  plug :scrub_params, "dish" when action in [:create, :update]
  plug :find_user
  plug :action


  def new(conn, _params) do
    changeset = Dish.changeset(%Dish{})
    render conn, changeset: changeset
  end

  def create(conn, params) do
    dish_params = params["dish"]

    user = Trophus.Repo.get(Trophus.User, String.to_integer(params["user_id"]))

    ss = ErlasticSearch.erls_params(host: System.get_env("ELASTIC_URL"))
    check_id = (Trophus.Repo.all(Trophus.Dish) |> List.last)
 #    {:ok,
 # %{"_id" => "AU44KyWULR8VkXx1JIL-", "_index" => "trophus", "_type" => "dishes",
 #   "_version" => 1, "created" => true}}
    changeset1 = 
    build(conn.assigns.user, :dishes)
    |> Dish.changeset(dish_params)

    if changeset1.valid? do
      IO.inspect "THIS IS CHANGESET1"
      IO.inspect changeset1

      xyz = Repo.insert(changeset1)
      submission = :erlastic_search.index_doc(ss, "trophus", "dishes", [{"name", dish_params["name"]}, {"description", dish_params["description"]}, {"user_id", user.id}, {"dish_id", xyz.id} ])
      {:ok, %{"_id" => es_id}} = submission
      newmap = Map.merge dish_params, %{"es_id" => es_id}
      IO.inspect newmap

      changeset2 = 
      build(conn.assigns.user, :dishes)
      |> Dish.changeset(%{"es_id" => es_id, "dish_id" => xyz.id})

      if changeset2.valid? do
        IO.puts "THIS IS CHANGESET2"
        Repo.update(changeset2)
      end

      conn
      |> put_flash(:info, "Dish created successfully.")
      |> redirect(to: user_dish_path(conn, :index, conn.assigns.user))
    else
      render(conn, "new.html", changeset: changeset1)
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
    ss = ErlasticSearch.erls_params(host: System.get_env("ELASTIC_URL"))
    IO.puts "Deleting dish #{id} from elasticsearch"
    IO.inspect ss
    IO.puts "Checking the id"
    IO.inspect Repo.get(Dish, id)
    IO.inspect :erlastic_search.delete_doc(ss, "trophus", "dishes", Repo.get(Dish, id).es_id)

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
