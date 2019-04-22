defmodule PhoenixBoilerplateWeb.UserView do
  use PhoenixBoilerplateWeb, :view

  alias PhoenixBoilerplate.Accounts

  def first_name(%Accounts.User{name: name}) do
    name
    |> String.split(" ")
    |> Enum.at(0)
  end
end
