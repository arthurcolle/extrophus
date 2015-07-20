defmodule Trophus.SearchController do
	require ErlasticSearch

	use Trophus.Web, :controller
  
  def get_nearest(conn, params) do
  	query = params["query"]
  	# IO.inspect query
  	elastic_instance = ErlasticSearch.erls_params(host: System.get_env("ELASTIC_URL"))
  	
  	name_result = :erlastic_search.search(elastic_instance, "trophus", "name:#{query}*")  
  	desc_result = :erlastic_search.search(elastic_instance, "trophus", "description:#{query}*")
  	{:ok, names} = name_result
  	{:ok, descs} = desc_result

    name_hits = names["hits"]["hits"]
    desc_hits = descs["hits"]["hits"]

    hits = name_hits ++ desc_hits
  	
    item_names = hits 
    |> Enum.map fn(item) -> 
        ([
          "dish", 
          item["_source"]["user_id"], 
          item["_source"]["dish_id"], 
          item["_source"]["name"]
        ]) 
       end

    # item_names 
    # |> Enum.map fn(["dish", uid, did, dnm]) ->
    #      ([])

    json conn, %{results: ((item_names |> Enum.map fn(["dish", uid, did, dnm]) -> ["dish", uid, did, dnm] end))}

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
   
  end

  def display do

  end
end