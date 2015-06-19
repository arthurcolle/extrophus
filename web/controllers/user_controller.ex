defmodule Trophus.UserController do
  use Trophus.Web, :controller

  alias Trophus.User

  plug :scrub_params, "user" when action in [:create, :update]
  plug :action

  def jsonify(conn, %{"id" => id}) do
    Trophus.Repo.all(Trophus.User) 
    |> Enum.filter fn(x) -> x.id == id end
    |> Poison.encode!
    render(conn)
  end

  def auth_callback(conn, params) do
    token = Instagram.get_token!(%{:code => params["code"]})
    IO.inspect token
    images = Instagram.user_recent_media(token.access_token)
    user = Trophus.Repo.get(User, conn.private.plug_session["current_user"])
    changeset = User.changeset(user, %{"instagram_token" => token.access_token})

    if changeset.valid? do
      Repo.update(changeset)

      conn
      |> put_flash(:info, "Instagram token added to database")
    end
    render(conn, "profile.html")
  end

  def instagram(conn, _params) do
    user = Trophus.Repo.get(User, conn.private.plug_session["current_user"])
    images = Instagram.user_recent_media(user.instagram_token)
    |> Enum.map fn(x) -> x["images"]["thumbnail"]["url"] end
    render(conn, "instagram.html", images: images)
  end

  def customer(conn, params) do
    # IO.inspect "Checking token"
    # IO.inspect params["token"]
    current_user_id = conn.private.plug_session["current_user"]
    customer = %{"customer_id" => params["token"]}
    changeset = User.changeset Repo.get!(User, current_user_id), customer
    if changeset.valid? do
      Repo.update(changeset)
      conn
      |> put_flash(:info, "User added payment info successfully.")
      |> redirect(to: user_path(conn, :profile))
    end

    # IO.inspect params["token"]
    render(conn, "index.html")
  end


  def add_ll(conn, params) do
    IO.inspect params
    user = Repo.get(User, conn.private.plug_session["current_user"])
    # lat = params["latitude"]
    # long = params["longitude"]
    # loc0 = String.to_float(params["latitude"])
    # loc1 = String.to_float(params["longitude"])
    changeset = User.changeset(user, params)
    IO.inspect changeset
    if changeset.valid? do
      Repo.update(changeset)
      conn
      |> put_flash(:info, "User latitude/longitude added successfully.")
    else
      render(conn, "index.html", changeset: changeset)
    end
  end  

  def index(conn, _params) do
    users = Repo.all(User)
    IO.inspect conn.private.plug_session["current_user"]
    render(conn, "index.html", users: users)
  end

  def profile(conn, _params) do
    url = Instagram.start
    user = Repo.get(User, conn.private.plug_session["current_user"])
    IO.inspect "The current user is... "
    IO.inspect user
    render(conn, "profile.html", url: url)
  end

  def new(conn, _params) do
    changeset = User.changeset(%User{})
    render(conn, "new.html", changeset: changeset)
  end

  def create(conn, %{"user" => user_params}) do
    changeset = User.changeset(%User{}, user_params)

    if changeset.valid? do
      Repo.insert(changeset)
      conn
      |> put_flash(:info, "User created successfully.")
      |> redirect(to: user_path(conn, :index))
    else
      render(conn, "new.html", changeset: changeset)
    end
  end

  def show(conn, %{"id" => id}) do
    user = Repo.get(User, id)
    render(conn, "show.html", user: user)
  end

  def edit(conn, %{"id" => id}) do
    user = Repo.get(User, id)
    changeset = User.changeset(user)
    render(conn, "edit.html", user: user, changeset: changeset)
  end

  def update(conn, %{"id" => id, "user" => user_params}) do
    user = Repo.get(User, id)
    changeset = User.changeset(user, user_params)

    if changeset.valid? do
      Repo.update(changeset)
      conn
      |> put_flash(:info, "User updated successfully.")
      |> redirect(to: user_path(conn, :index))
    else
      render(conn, "edit.html", user: user, changeset: changeset)
    end
  end

  def delete(conn, %{"id" => id}) do
    user = Repo.get(User, id)
    Repo.delete(user)
    conn
    |> put_flash(:info, "User deleted successfully.")
    |> redirect(to: user_path(conn, :index))
  end
end
