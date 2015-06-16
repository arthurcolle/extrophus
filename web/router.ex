defmodule HelloPhoenix.Router do
  use HelloPhoenix.Web, :router

  pipeline :browser do
    plug :accepts, ["html"]
    plug :fetch_session
    plug :fetch_flash
    plug :protect_from_forgery
  end


  pipeline :api do
    plug :accepts, ["json"]
  end



  scope "/", HelloPhoenix do
    pipe_through :browser # Use the default browser stack
    get "/auth/callback", PageController, :auth_callback
    get "/", PageController, :index
    get "/about", PageController, :about
    get "/hello", HelloController, :index
    get "/hello/:messenger", HelloController, :show
    resources "/users", UserController do
      resources "/dishes", DishController
    end
    
    # see 
    #
    #       https://github.com/opendrops/passport
    #
    # for more on passport
    get "/login", SessionController, :new
    post "/login", SessionController, :create
    get "/logout", SessionController, :delete

    get "/signup", RegistrationController, :new
    post "/signup", RegistrationController, :create
  end

  # Other scopes may use custom stacks.
  # scope "/api", HelloPhoenix do
  #   pipe_through :api
  # end
end
