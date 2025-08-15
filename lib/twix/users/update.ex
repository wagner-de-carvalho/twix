defmodule Twix.Users.Update do
  alias Twix.Repo
  alias Twix.Users
  alias Twix.Users.User

  def call(%{id: id} = params) do
    id
    |> Users.Get.call()
    |> update(params)
  end

  defp update({:error, _} = error, _), do: error

  defp update({:ok, user}, params) do
    user
    |> User.changeset(params)
    |> Repo.update()
  end
end
