defmodule CrowdReviewWeb.PageControllerTest do
  use CrowdReviewWeb.ConnCase, async: true

  test "GET /", %{conn: conn} do
    conn = get(conn, "/")

    assert html_response(conn, 200) =~ "Crowd Review"
    assert html_response(conn, 200) =~ "Request a Review"
    assert html_response(conn, 200) =~ "Give a Review"
  end
end
