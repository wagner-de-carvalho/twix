defmodule Twix.Users.User do
  @moduledoc """
  User struct
  """
  use Ecto.Schema
  import Ecto.Changeset
  alias Twix.Posts.Post

  @fields ~w/age email nickname/a
  @required @fields

  schema "users" do
    field :nickname, :string
    field :email, :string
    field :age, :integer
    has_many :posts, Post

    timestamps()
  end

  def changeset(attrs), do: changeset(%__MODULE__{}, attrs)

  def changeset(%__MODULE__{} = user, attrs) do
    user
    |> cast(attrs, @fields)
    |> validate_required(@required)
    |> validate_length(:nickname, min: 3)
    |> validate_number(:age, greater_than_or_equal_to: 18)
    |> validate_format(:email, ~r/@/)
    |> unique_constraint(:nickname)
    |> unique_constraint(:email)
  end
end
