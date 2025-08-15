defmodule Twix.Users.Follower do
  use Ecto.Schema
  import Ecto.Changeset
  alias Twix.Users.User

  @fields ~w/follower_id following_id/a
  @required @fields

  @primary_key false
  schema "followers" do
    belongs_to :follower, User
    belongs_to :following, User
  end

  def changeset(params) do
    %__MODULE__{}
    |> cast(params, @fields)
    |> validate_required(@required)
    |> foreign_key_constraint(:follower_id)
    |> foreign_key_constraint(:following_id)
    |> unique_constraint(@required)
  end
end
