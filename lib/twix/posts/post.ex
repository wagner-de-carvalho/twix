defmodule Twix.Posts.Post do
  @moduledoc false
  use Ecto.Schema
  import Ecto.Changeset
  alias Twix.Users.User

  @required_params ~w/text user_id/a

  schema "posts" do
    field :likes, :integer, default: 0
    field :text, :string

    belongs_to :user, User
    timestamps()
  end

  def changeset(post \\ %__MODULE__{}, params) do
    post
    |> cast(params, @required_params)
    |> validate_required(@required_params)
    |> validate_length(:text, min: 1, max: 300)
    |> foreign_key_constraint(:user_id)
    |> unique_constraint(:user_id)
  end
end
