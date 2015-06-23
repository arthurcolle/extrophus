defmodule Trophus.SearchController do
	use Trophus.Web, :controller
	plug :action
  def get_nearest(conn, params) do
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

	  	# data = %{	
	  	# 	current_user: c.id, 
	  	# 	other_user: x.id, 
	  	# 	distance: Compare.distance(x_geo, current_user_geo)
	  	# }
    	# data

    	dx = {x.id, Compare.distance(x_geo, current_user_geo)}   	
    	dx
    end)
    better_list =
    (tuple_list 
    |> List.keysort 1)
    |> Enum.map fn(x) -> Tuple.to_list x end

    expanded = 
    better_list
    |> Enum.map fn(elt) ->
    	   num = hd elt
    	   dst = List.last elt
    	   other_user = Trophus.Repo.get(Trophus.User, num)
    	   oname = other_user.name
    	   id = other_user.id
    	   [id, oname, dst]
    	 end
    IO.inspect expanded
    json conn, %{results: expanded}
  end

  def display do

  end
end