defmodule Twix.Users.Get do
  @moduledoc false
  alias Twix.Repo
  alias Twix.Users.User

  def call(id) do
    Repo.get(User, id)
    |> then(fn
      nil ->
        {:error, :not_found}

      user ->
        {:ok, Repo.preload(user, followers: [:follower], followings: [:following], posts: [])}
    end)
  end
end
