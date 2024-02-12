defmodule Twix.Posts.Create do
  @moduledoc false
  alias Twix.Repo
  alias Twix.Posts.Post

  def call(params) do
    params
    |> Post.changeset()
    |> Repo.insert()
  end
end
