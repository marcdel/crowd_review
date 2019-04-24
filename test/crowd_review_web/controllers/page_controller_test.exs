defmodule CrowdReviewWeb.PageControllerTest do
  use CrowdReviewWeb.ConnCase, async: true

  test "GET /", %{conn: conn} do
    conn = get(conn, "/")

    assert html_response(conn, 200) =~ "Crowd Review"
    assert html_response(conn, 200) =~ "Give a Review"
    assert html_response(conn, 200) =~ "Get a Review"
  end
end
