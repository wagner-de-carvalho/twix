defmodule Twix.Users.User do
  @moduledoc false
  use Ecto.Schema
  import Ecto.Changeset
  alias Twix.Posts.Post

  @required_params ~w/text user_id email nickname/a

  schema "users" do
    field :age, :integer, default: 0
    field :email, :string
    field :nickname, :string

    has_many :posts, Post
    timestamps()
  end

  def changeset(user \\ %__MODULE__{}, params) do
    user
    |> cast(params, @required_params)
    |> validate_required(@required_params)
    |> validate_length(:nickname, min: 2)
    |> validate_number(:age, greater_than_or_equal_to: 18)
    |> unique_constraint(:nickname)
    |> unique_constraint(:email)
  end
end
