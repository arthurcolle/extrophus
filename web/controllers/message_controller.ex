defmodule Trophus.MessageController do
  use Trophus.Web, :controller

  alias Trophus.Message
  alias Trophus.User

  plug :scrub_params, "message" when action in [:create, :update]

  def index(conn, _params) do
    messages = Repo.all from m in Message, order_by: [desc: m.updated_at]
    render(conn, "index.html", messages: messages)
  end

  def new(conn, params) do
    IO.puts "messages/new"
    IO.inspect params
    changeset = Message.changeset(%Message{})
    render(conn, "new.html", changeset: changeset)
  end

  def create(conn, %{"message" => message_params}) do
    IO.puts "message params"
    IO.inspect message_params
    changeset = Message.changeset(%Message{}, message_params)
    recipient_id = String.to_integer(message_params["recipient_id"])
    user = Trophus.Repo.get(Trophus.User, recipient_id)
    cset = User.changeset(user, %{unread: (user.unread + 1)})

    if changeset.valid? do
      Repo.insert!(changeset)
      if cset.valid? do
        Repo.update! cset
      end

      conn
      |> put_flash(:info, "Message created successfully.")
      |> redirect(to: message_path(conn, :index))
    else
      render(conn, "new.html", changeset: changeset)
    end
  end

  def show(conn, %{"id" => id}) do
    message = Repo.get!(Message, id)
    recipient = Repo.get!(User, message.recipient_id)
    if recipient.unread <= 0 do
      cset = User.changeset(recipient, %{unread: 0})
    else
      cset = User.changeset(recipient, %{unread: (recipient.unread - 1)})
    end
    if cset.valid? do
      Repo.update! cset
    end
    render(conn, "show.html", message: message)
  end

  def edit(conn, %{"id" => id}) do
    message = Repo.get!(Message, id)
    changeset = Message.changeset(message)
    render(conn, "edit.html", message: message, changeset: changeset)
  end

  def update(conn, %{"id" => id, "message" => message_params}) do
    message = Repo.get!(Message, id)
    changeset = Message.changeset(message, message_params)

    if changeset.valid? do
      Repo.update!(changeset)

      conn
      |> put_flash(:info, "Message updated successfully.")
      |> redirect(to: message_path(conn, :index))
    else
      render(conn, "edit.html", message: message, changeset: changeset)
    end
  end

  def delete(conn, %{"id" => id}) do
    message = Repo.get!(Message, id)
    Repo.delete!(message)

    conn
    |> put_flash(:info, "Message deleted successfully.")
    |> redirect(to: message_path(conn, :index))
  end
end
