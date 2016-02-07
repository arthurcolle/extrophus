defmodule Trophus.RegistrationController do
  use Trophus.Web, :controller

  alias Trophus.User
  alias Passport.RegistrationManager

  def new(conn, _params) do
    conn
    |> put_session(:foo, "bar")
    |> render("new.html")
  end

  def create(conn, %{"registration" => registration_params}) do
    IO.inspect registration_params
<<<<<<< HEAD
    case RegistrationManager.register(conn, registration_params) do
      {:ok} -> conn
         |> put_flash(:info, "Registration success")
         |> redirect(to: page_path(conn, :index))
      _x -> 
        IO.inspect _x
        conn
=======
    case RegistrationManager.register(registration_params) do
      {:ok} -> conn
         |> put_flash(:info, "Registration success")
         |> redirect(to: page_path(conn, :index))
      _ -> conn
>>>>>>> f84a03f2eacbef5666f236c1963d2cc72e7d2711
         |> put_flash(:info, "Registration failed")
         |> redirect(to: page_path(conn, :index))
    end
  end

end