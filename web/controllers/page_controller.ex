defmodule Trophus.PageController do
  use Trophus.Web, :controller
  alias Trophus.Helpers
  plug :action

  def index(conn, _params) do
    IO.puts "Hello users"
  	url = Instagram.start
    render conn, "index.html", url: url
  end

  # def chat(conn, _params) do
  #   render conn, "chat.html"
  # end

  def get_nearest(conn) do
    fact_list = []
    IO.puts "Checking params"
    {:ok, agent} = Agent.start_link fn -> [] end
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
        # item = "{\"source\":#{curr},\"dest\":#{x.id},\"distance\":#{dist}}"
        item = "#{dist} distance between #{myname} and #{yoname}"
        Agent.update(agent, fn list -> [item|list] end)
    end
    Agent.get(agent, fn list -> list end)
  end


  def distance(conn, _params) do
    IO.puts "Hello distance"
    facts = get_nearest(conn)
    IO.puts "facts are..."
    IO.puts facts
    render conn, "distance.html", facts: facts
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
