defmodule Twix.Posts.Get do
  @moduledoc false
  import Ecto.Query
  alias Twix.Posts.Post
  alias Twix.Repo

  def call(user, page, per_page) do
    Post
    |> where([p], p.user_id == ^user.id)
    |> order_by([p], desc: p.id)
    |> offset((^page - 1) * ^per_page)
    |> limit(^per_page)
    |> Repo.all()
  end
end
