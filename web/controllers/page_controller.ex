defmodule Trophus.PageController do
  use Trophus.Web, :controller
  alias Trophus.Helpers
  plug :action

  def index(conn, _params) do
    IO.puts "Hello users"
    IO.inspect conn.private.plug_session["current_user"]
  	url = Instagram.start
    render conn, "index.html", url: url
  end

  def get_nearest(conn) do
    IO.puts "Checking params"
    curr = conn.private.plug_session["current_user"]
    user = Trophus.Repo.get(Trophus.User, curr)
    myname = Trophus.Repo.get(Trophus.User, curr).name

    lat = user.latitude
    lng = user.longitude
    other_users = 
    Trophus.Repo.all(Trophus.User)
    |> Enum.filter fn(x) -> x.id != curr end

    other_users 
    |> Enum.map fn(x) -> 
        yoname = Trophus.Repo.get(Trophus.User, x.id).name
        dist = Compare.distance(
          %{"latitude" => lat, "longitude" => lng},
          %{"latitude" => x.latitude, "longitude" => x.longitude}
        )
        IO.puts "#{dist} distance between #{myname} and #{yoname}"
    end
  end


  def distance(conn, _params) do
    IO.puts "Hello distance"
    get_nearest(conn)
    render conn, "distance.html"
  end

  def explore(conn, _params) do

    IO.puts "The current user is..."
    IO.puts conn.private.plug_session["current_user"]

    users = Trophus.Repo.all(Trophus.User) 
    |> Enum.map fn(x) -> Poison.encode! x end

    render conn, "explore.html", users: users
  end

  def thanks(conn, params) do
    IO.inspect params
    render conn, "thanks.html", params: params
  end

  def about(conn, _params) do
    render conn, "about.html"
  end
end
