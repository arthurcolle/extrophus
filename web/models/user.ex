defmodule HelloPhoenix.User do
  use HelloPhoenix.Web, :model

  schema "users" do
    has_many :dishes, HelloPhoenix.Dish
    field :email, :string
    field :name, :string
    field :username, :string
    field :crypted_password, :string
    timestamps
  end

  @required_fields ~w(email crypted_password)
  @optional_fields ~w(name username)

  @doc """
  Creates a changeset based on the `model` and `params`.

  If `params` are nil, an invalid changeset is returned
  with no validation performed.
  """
  def changeset(model, params \\ :empty) do
    model
    |> cast(params, @required_fields, @optional_fields)
  end
end
