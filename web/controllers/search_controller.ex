defmodule Trophus.SearchController do
	require ErlasticSearch
	use Trophus.Web, :controller
	plug :action
  def get_nearest(conn, params) do
  	query = params["query"]
  	IO.inspect query
  	ss = ErlasticSearch.erls_params(host: System.get_env("ELASTIC_URL"))
  	
  	result = :erlastic_search.search(ss, "trophus", "name:#{query}*")  
  	#result2 = :erlastic_search.search(ss, "trophus", "description:#{query}*")
  	{:ok, res} = result
    IO.puts "--------------------------------"
    IO.puts "BINGO IS STARTING"
    hits = res |> Enum.filter fn({x,y}) -> if x == "hits" do y end end
    #[{"total",_a},{"max_score",_b},{"hits",bingo}]
    [{"hits", %{"hits" => rest}}] = hits
    item_names = rest |>
    Enum.map fn(rest_item) ->
      Poison.encode! rest_item end
    IO.inspect item_names
    #bingo |> Enum.map fn(list_elt) -> IO.inspect list_elt end
    IO.puts "BINGO IS OVER"
    IO.puts "--------------------------------"

  	# IO.inspect res
  	# {:ok, res2} = result2
  	# IO.inspect res2
  	# rex = Map.merge res, res2
  	# IO.inspect rex
  	# IO.inspect res["hits"]
  	# names = 
  	# res["hits"]
  	# |> Enum.map fn(hit) -> hit end
  	# IO.puts "names are..."
  	# {:ok, {"hits", gett}} = names |> Enum.fetch 0
  	# IO.inspect gett
  	# item_names = gett
  	# |> Enum.map fn(item) -> ["dish", item["_source"]["user_id"], item["_source"]["dish_id"], item["_source"]["name"]] end

  	# curr_id = conn.private.plug_session["current_user"]
  	# users = Trophus.Repo.all(Trophus.User) |> Enum.filter fn(x) -> x.id != curr_id end

  	# current_user = Trophus.Repo.get(Trophus.User, curr_id)
  	# c = current_user
  	# current_user_geo = %{
  	# 	latitude: c.latitude, 
  	# 	longitude: c.longitude
  	# }
   #  tuple_list = 
   #  (users |>
   #  Enum.map fn(x) ->
   #  	x_geo = %{
   #  		latitude: x.latitude, 
   #  		longitude: x.longitude
   #  	}

	  # 	# data = %{	
	  # 	# 	current_user: c.id, 
	  # 	# 	other_user: x.id, 
	  # 	# 	distance: Compare.distance(x_geo, current_user_geo)
	  # 	# }
   #  	# data

   #  	dx = {x.id, Compare.distance(x_geo, current_user_geo)}   	
   #  	dx
   #  end)
   #  better_list =
   #  (tuple_list 
   #  |> List.keysort 1)
   #  |> Enum.map fn(x) -> Tuple.to_list x end

   #  expanded = 
   #  better_list
   #  |> Enum.map fn(elt) ->
   #  	   num = hd elt
   #  	   dst = List.last elt
   #  	   other_user = Trophus.Repo.get(Trophus.User, num)
   #  	   oname = other_user.name
   #  	   id = other_user.id
   #  	   ["user", id, oname, dst]
   #  	 end
   #  IO.inspect  (expanded ++ (item_names |> Enum.map fn(["dish", uid, did, dnm]) -> ["dish", uid, did, dnm] end))
   #  json conn, %{results: (expanded ++ (item_names |> Enum.map fn(["dish", uid, did, dnm]) -> ["dish", uid, did, dnm] end))}
    json conn, %{results: item_names}
  end

  def display do

  end
end