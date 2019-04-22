defmodule CrowdReviewWeb.UserView do
  use CrowdReviewWeb, :view

  alias CrowdReview.Accounts

  def first_name(%Accounts.User{name: name}) do
    name
    |> String.split(" ")
    |> Enum.at(0)
  end
end
