defmodule Twix.Posts.AddLike do
  alias Twix.Repo
  alias Twix.Posts.Post

  def call(id) do
    case Repo.get(Post, id) do
      nil -> {:error, :not_found}
      %Post{} = post -> add_like(post)
    end
  end

  defp add_like(post) do
    likes = post.likes + 1

    post
    |> Post.changeset(%{likes: likes})
    |> IO.inspect(label: "changeset post >> ")
    |> Repo.update()
  end
end
