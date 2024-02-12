defmodule Twix.Users.Create do
  @moduledoc false
  alias Twix.Repo
  alias Twix.Users.User

  def call(params) do
    params
    |> User.changeset()
    |> Repo.insert()
  end
end
