defmodule Twix.Users.Follower do
  use Ecto.Schema
  import Ecto.Changeset

  alias Twix.Users.User

  @required_params ~w/follower_id following_id/a

  @primary_key false
  schema "followers" do
    belongs_to :follower, User
    belongs_to :following, User
  end

  def changeset(params), do: changeset(%__MODULE__{}, params)

  def changeset(follower, params) do
    follower
    |> cast(params, @required_params)
    |> validate_required(@required_params)
    |> unique_constraint(@required_params)
  end
end
