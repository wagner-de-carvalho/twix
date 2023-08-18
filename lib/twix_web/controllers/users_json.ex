defmodule TwixWeb.UsersJSON do
  def index(%{data: %{users: users}}) do
    %{users: for(user <- users, do: data(user))}
  end

  defp data(user) do
    %{nickname: user.nickname, age: user.age, email: user.email, id: user.id}
  end
end
