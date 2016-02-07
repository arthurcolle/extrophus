defmodule Trophus.Message do
  use Trophus.Web, :model

  schema "messages" do
    belongs_to :sender, Trophus.User, foreign_key: :sender_id
    belongs_to :recipient, Trophus.User, foreign_key: :recipient_id
    belongs_to :conversation, Trophus.Conversation, foreign_key: :conversation_id
    field :body, :string
    field :read, :boolean, default: false
    timestamps
  end

  @required_fields ~w(sender_id recipient_id body)
  @optional_fields ~w(conversation_id read)

  @doc """
  Creates a changeset based on the `model` and `params`.

  If no params are provided, an invalid changeset is returned
  with no validation performed.
  """

  def changeset(model, params \\ :empty) do
    model
    |> cast(params, @required_fields, @optional_fields)
  end
end
