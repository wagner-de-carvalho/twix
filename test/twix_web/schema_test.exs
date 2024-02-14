defmodule TwixWeb.SchemaTest do
  @moduledoc false
  use TwixWeb.ConnCase, async: true

  describe "users query" do
    test "returns a user", %{conn: conn} do
      user_params = %{nickname: "josé", age: 35, email: "josevalim@mail.com"}

      {:ok, user} = Twix.create_user(user_params)

      query = """
      {
        user(id: #{user.id}) {
          nickname
          email
        }
      }
      """

      response =
        post(conn, "/api/graphql", %{query: query})
        |> json_response(200)

      assert response == %{
               "data" => %{"user" => %{"email" => "josevalim@mail.com", "nickname" => "josé"}}
             }
    end

    test "returns an error when user does not exist", %{conn: conn} do
      query = """
      {
        user(id: 999) {
          nickname
          email
        }
      }
      """

      response =
        post(conn, "/api/graphql", %{query: query})
        |> json_response(200)

      assert response == %{
               "data" => %{"user" => nil},
               "errors" => [
                 %{
                   "locations" => [%{"column" => 3, "line" => 2}],
                   "message" => "not_found",
                   "path" => ["user"]
                 }
               ]
             }
    end
  end

  describe "users mutation" do
    test "when all params are valid creates a user", %{conn: conn} do
      query = """
      mutation {
          createUser(input: {age: 35, email: "josevalim@mail.com", nickname: "josé"}) {
          id
          nickname
        }
      }
      """

      response =
        post(conn, "/api/graphql", %{query: query})
        |> json_response(200)

      assert %{"data" => %{"createUser" => %{"id" => _id, "nickname" => "josé"}}} = response
    end
  end

  # describe "users subscription" do
  #   test "", %{conn: conn} do
  #   end
  # end
end
