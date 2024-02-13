defmodule Twix.Users.User do
  @moduledoc false
  use Ecto.Schema
  import Ecto.Changeset
  alias Twix.Posts.Post
  alias Twix.Users.Follower

  @required_params ~w/age email nickname/a
  @update_required_params ~w/id/a

  schema "users" do
    field :age, :integer, default: 0
    field :email, :string
    field :nickname, :string

    has_many :posts, Post
    has_many :followers, Follower, foreign_key: :following_id
    has_many :followings, Follower, foreign_key: :follower_id

    timestamps()
  end

  def update_changeset(user \\ %__MODULE__{}, params) do
    user
    |> cast(params, @required_params)
    |> validate_required(@update_required_params)
    |> validate_length(:nickname, min: 2)
    |> validate_number(:age, greater_than_or_equal_to: 18)
    |> unique_constraint(:nickname)
    |> unique_constraint(:email)
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
