defmodule Twix.Posts.AddLike do
  alias Ecto.Changeset
  alias Twix.Posts.Post
  alias Twix.Repo

  def call(id) do
    case Repo.get(Post, id) do
      nil -> {:error, :not_found}
      post -> add_like(post)
    end
  end

  defp add_like(post) do
    (post.likes + 1)
    |> then(&Changeset.change(post, likes: &1))
    |> then(&Repo.update(&1))
  end
end
