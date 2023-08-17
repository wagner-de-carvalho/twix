defmodule Twix.Posts.Get do
  import Ecto.Query
  alias Twix.Posts.Post
  alias Twix.Repo

  def call(user, page \\ 1, per_page \\ 5) do
    posts_query =
      from p in Post,
        where: p.user_id == ^user.id,
        order_by: [desc: p.id],
        offset: (^page - 1) * ^per_page,
        limit: ^per_page

    {:ok, Repo.all(posts_query)}
  end
end
