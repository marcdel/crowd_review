defmodule Fixtures do
  alias CrowdReview.{Accounts, Language, Repo}

  def registered_user(attrs \\ %{}) do
    default_user_attrs = %{
      id: 1,
      name: "User1",
      username: "user1",
      credential: %{
        email: "user1@email.com",
        password: "password"
      }
    }

    {:ok, user} =
      default_user_attrs
      |> Map.merge(attrs)
      |> Accounts.register_user()

    user
  end

  @valid_language %{id: 1, name: "Javascript"}

  def language_fixture(attrs \\ %{}) do
    attrs = Enum.into(attrs, @valid_language)

    {:ok, language} =
      %Language{}
      |> Language.changeset(attrs)
      |> Repo.insert()

    language
  end
end
