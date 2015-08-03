defmodule Trophus.PageController do
  use Trophus.Web, :controller
  import Trophus.Helpers

  def index(conn, _params) do
    IO.puts "Hello users"
  	url = Instagram.start
    #currord = Trophus.Helpers.current_order(conn)
    render conn, "index.html", url: url #, current_order: currord
  end

  # def chat(conn, _params) do
  #   render conn, "chat.html"
  # end

  def wstest(conn, _params) do
    render(conn, "wstest.html")
  end

  def get_nearest(conn) do
    fact_list = []
    IO.puts "Checking params"
    {:ok, agent} = Agent.start_link fn -> [] end
    curr = conn.private.plug_session["current_user"]
    user = Trophus.Repo.get(Trophus.User, curr)
    myname = Trophus.Repo.get(Trophus.User, curr).name

    lat = user.latitude
    lng = user.longitude
    
    other_users = Trophus.Repo.all(Trophus.User)
    |> Enum.filter fn(x) -> x.id != curr end

    other_users 
    |> Enum.map fn(x) -> 
        yoname = Trophus.Repo.get(Trophus.User, x.id).name
        dist = Compare.distance(
          %{latitude: lat, longitude: lng},
          %{latitude: x.latitude, longitude: x.longitude}
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

  def map(conn, _params) do
    curr_id = conn.private.plug_session["current_user"]
    users = Trophus.Repo.all(Trophus.User) |> Enum.filter fn(x) -> x.id != curr_id end
    current_user = Trophus.Repo.get(Trophus.User, curr_id)
    c = current_user
    current_user_geo = %{
      latitude: c.latitude, 
      longitude: c.longitude
    }
    
    tuple_list = 
    (users |>
    Enum.map fn(x) ->
      x_geo = %{
        latitude: x.latitude, 
        longitude: x.longitude
      }

      data = %{ 
        current_user: c.id, 
        other_user: x.id, 
        distance: Compare.distance(x_geo, current_user_geo)
      }
      data
    end)
    
    IO.puts "The current tuples are..."
    IO.inspect tuple_list
    closest = 
    tuple_list |> Enum.filter fn(tp) -> tp[:distance] < 10.0 end

    IO.puts "The closest tuples are..."
    IO.inspect closest

    IO.puts "The current user is..."
    IO.puts conn.private.plug_session["current_user"]

    users = closest
    |> Enum.map fn(u) -> Trophus.Repo.get(Trophus.User, u[:other_user]) end

    users_as_json = users
    |> Enum.map fn(x) -> :jsx.encode x end

    # users_as_json = []
    IO.puts "The other users are..."
    IO.inspect users
    users_preloaded = Trophus.Repo.all(Trophus.User) |> Trophus.Repo.preload :dishes
    dishes_all = users_preloaded |> Enum.map fn(user) -> user.dishes end

    if Enum.count(users) < 1 do
      render conn, "thanks.html"
    else
      render conn, "map.html", users: users_as_json, users_preloaded: users_preloaded, dishes: dishes_all
    end 
  end

  def how_it_works(conn, _params) do
    render conn, "how_it_works.html"
  end

  def thanks(conn, params) do
    IO.inspect params
    render conn, "thanks.html", params: params
  end

  def about(conn, _params) do
    render conn, "about.html"
  end
end
