defmodule Twix.Posts.Post do
  @moduledoc """
  Post struct
  """
  use Ecto.Schema
  import Ecto.Changeset
  alias Twix.Users.User

  @fields ~w/likes text user_id/a
  @required @fields -- [:likes]

  schema "posts" do
    field :text, :string
    field :likes, :integer, default: 0
    belongs_to :user, User

    timestamps()
  end

  def changeset(attrs), do: changeset(%__MODULE__{}, attrs)

  def changeset(%__MODULE__{} = post, attrs) do
    post
    |> cast(attrs, @fields)
    |> validate_required(@required)
    |> validate_length(:text, min: 1, max: 300)
    |> foreign_key_constraint(:user_id)
  end
end
