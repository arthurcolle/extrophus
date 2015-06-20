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
    user = Repo.get(User, conn.private.plug_session["current_user"])
    users = Trophus.Repo.all(Trophus.User)
    changeset = User.changeset(user, %{"instagram_token" => token.access_token})

    if changeset.valid? do
      Repo.update(changeset)
      conn
      |> put_flash(:info, "Instagram token added to database")
    end
    render(conn, "index.html", users: users)
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
    tkn = params["token"]
    user = Repo.get!(User, current_user_id)
    username = user.name
    desc = username <> " customer token"
    HTTPotion.start
    response = HTTPotion.post "https://api.stripe.com/v1/customers", [body: "source="<>tkn<>"&description=" <> "\"#{desc}\"", headers: ["Content-type": "application/x-www-form-urlencoded", "Authorization": "Bearer sk_test_aqQo51A1cGQEk09BCaCGmkYZ"]]
    obj = Poison.decode! response.body
    customer_id = obj["id"]

    IO.puts customer_id
    response = HTTPotion.post "https://api.stripe.com/v1/accounts", [body: "country=US&managed=true", headers: ["Content-type": "application/x-www-form-urlencoded", "Authorization": "Bearer sk_test_aqQo51A1cGQEk09BCaCGmkYZ"]]
    bd = response.body
    dc = bd |> Poison.decode!
    pub = dc["keys"]["publishable"]     # publishable_key
    sct = dc["keys"]["secret"]          # secret_key
    act = dc["id"]                      # connect_id
    cset = %{customer_id: customer_id, publishable_key: pub, secret_key: sct, connect_id: act}
    IO.puts "~~~~~~~~~~~~~~~~~~~~~~~~~~~~"
    IO.puts "Watch the cset!"
    IO.inspect cset
    IO.puts "~~~~~~~~~~~~~~~~~~~~~~~~~~~~"
    changeset = User.changeset Repo.get!(User, current_user_id), cset
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
    users = Trophus.Repo.all(Trophus.User)
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
    end
    render(conn, "index.html", changeset: changeset, users: users)
  end  

  def index(conn, _params) do
    users = Repo.all(User)
    IO.inspect conn.private.plug_session["current_user"]
    render(conn, "index.html", users: users)
  end

  def profile(conn, _params) do
    url = Instagram.start
    user = Repo.get(User, conn.private.plug_session["current_user"])
    # IO.inspect "The current user is... "
    # IO.inspect user
    {:ok, firstname} = String.split(user.name, " ") |> Enum.fetch 0
    {:ok, lastname} = String.split(user.name, " ") |> Enum.fetch 1
    render(conn, "profile.html", url: url, fname: firstname, lname: lastname, current_user: user)
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
