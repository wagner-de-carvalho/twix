defmodule Twix.Users.Follow do
  @moduledoc false
  alias Twix.Repo
  alias Twix.Users.Follower
  alias Twix.Users.User

  def call(user_id, follower_id) do
    with {:ok, _user} <- get_user(user_id),
         {:ok, _follower} <- get_user(follower_id),
         {:ok, _} <- avoid_self_following(user_id, follower_id) do
      add_follower(user_id, follower_id)
    end
  end

  defp add_follower(user_id, follower_id) do
    %{follower_id: follower_id, following_id: user_id}
    |> Follower.changeset()
    |> Repo.insert()
  end

  defp avoid_self_following(user_id, follower_id) do
    then(user_id != follower_id, fn
      false -> {:error, "You can't follow yourself!"}
      true -> {:ok, {user_id, follower_id}}
    end)
  end

  defp get_user(user_id) do
    Repo.get(User, user_id)
    |> then(fn
      nil -> {:error, :not_found}
      user -> {:ok, user}
    end)
  end
end
