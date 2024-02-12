defmodule Twix.Users.Update do
  @moduledoc false
  alias Twix.Repo
  alias Twix.Users.Get
  alias Twix.Users.User

  def call(%{id: id} = params) do
    Get.call(id)
    |> then(fn
      {:error, _} = error -> error
      {:ok, user} -> update(user, params)
    end)
  end

  defp update(user, params) do
    user
    |> User.changeset(params)
    |> Repo.update()
  end
end
