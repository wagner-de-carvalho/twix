defmodule TwixWeb.SchemaTest do
  use TwixWeb.ConnCase, async: true

  describe "users query" do
    test "returns a user", %{conn: conn} do
      user_params = %{nickname: "acme test", age: 33, email: "acmetest@mail.com"}
      {:ok, user} = Twix.create_user(user_params)

      query = """
        {
          user(id: #{user.id}) {
            email
            nickname
          }
        }
      """

      response =
        post(conn, "/api/graphql", %{query: query})
        |> json_response(200)

      expected_response = %{
        "data" => %{"user" => %{"nickname" => "acme test", "email" => "acmetest@mail.com"}}
      }

      assert response == expected_response
    end

    test "when there is no user, returns an error", %{conn: conn} do
      query = """
        {
          user(id: 999) {
            email
            nickname
          }
        }
      """

      response =
        post(conn, "/api/graphql", %{query: query})
        |> json_response(200)

      expected_response = %{
        "data" => %{"user" => nil},
        "errors" => [
          %{
            "locations" => [%{"column" => 5, "line" => 2}],
            "message" => "not_found",
            "path" => ["user"]
          }
        ]
      }

      assert response == expected_response
    end
  end

  describe "users mutation" do
    test "when all params are valid, creates a user", %{conn: conn} do
      query = """
          mutation {
          createUser(input: {age: 33, email: "acme@mail.com", nickname: "acme"}) {
            email
            nickname
          }
        }
      """

      response =
        post(conn, "/api/graphql", %{query: query})
        |> json_response(200)

      expected_response = %{
        "data" => %{"createUser" => %{"email" => "acme@mail.com", "nickname" => "acme"}}
      }

      assert response == expected_response
    end
  end
end
