defmodule Twix.Posts.AddLike do
  @moduledoc false
  alias Ecto.Changeset
  alias Twix.Posts.Post
  alias Twix.Repo

  def call(id) do
    Repo.get(Post, id)
    |> then(fn
      nil -> {:error, :not_found}
      post -> add_like(post)
    end)
  end

  defp add_like(post) do
    likes = post.likes + 1
    post = Changeset.change(post, likes: likes)
    Repo.update(post)
  end
end
