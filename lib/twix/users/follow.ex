defmodule Twix.Users.Follow do
  alias Twix.Repo
  alias Twix.Users.Follower
  alias Twix.Users.User

  def call(user_id, follower_id) when user_id == follower_id, do: {:error, :no_follow_yourself}

  def call(user_id, follower_id) do
    with {:ok, _user} <- get_user(user_id),
         {:ok, _follower} <- get_user(follower_id) do
      create_follower(user_id, follower_id)
    end
  end

  defp get_user(user_id) do
    case Repo.get(User, user_id) do
      nil -> {:error, :not_found}
      user -> {:ok, Repo.preload(user, :posts)}
    end
  end

  defp create_follower(user_id, follower_id) do
    %{follower_id: follower_id, following_id: user_id}
    |> Follower.changeset()
    |> Repo.insert()
  end
end
