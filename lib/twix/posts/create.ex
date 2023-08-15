defmodule Twix.Posts.Create do
  alias Twix.Posts.Post
  alias Twix.Repo

  def call(params) do
    params
    |> Post.changeset()
    |> Repo.insert()
  end
end
