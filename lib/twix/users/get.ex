defmodule Twix.Users.Get do
  alias Twix.Repo
  alias Twix.Users.User

  @preloads [[followers: [:following, :follower]], [followings: [:following, :follower]], :posts]

  def call(id) do
    case Repo.get(User, id) do
      nil -> {:error, :not_found}
      user -> {:ok, Repo.preload(user, @preloads)}
    end
  end
end
