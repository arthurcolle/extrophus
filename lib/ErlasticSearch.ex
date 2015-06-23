defmodule ErlasticSearch do
  require Record
  Record.defrecord( 
      :erls_params, 
      Record.extract(
    	  :erls_params, 
    	  from: "deps/erlastic_search/include/erlastic_search.hrl"
    )
  )
end