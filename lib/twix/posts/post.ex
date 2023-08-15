defmodule Twix.Posts.Post do
  use Ecto.Schema
  import Ecto.Changeset
  alias Twix.Users.User

  @required_params ~w/text user_id/a

  schema "posts" do
    field :text, :string
    field :likes, :integer, default: 0
    belongs_to :user, User

    timestamps()
  end

  def changeset(params), do: changeset(%__MODULE__{}, params)

  def changeset(post, params) do
    post
    |> cast(params, @required_params)
    |> validate_required(@required_params)
    |> validate_length(:text, min: 1, max: 300)
    |> foreign_key_constraint(:user_id)
    |> unique_constraint(:user_id)
  end
end
