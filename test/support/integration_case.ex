defmodule CrowdReviewWeb.IntegrationCase do
  use ExUnit.CaseTemplate

  using do
    quote do
      use CrowdReviewWeb.ConnCase
      use PhoenixIntegration
    end
  end
end
