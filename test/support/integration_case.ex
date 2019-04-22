defmodule PhoenixBoilerplateWeb.IntegrationCase do
  use ExUnit.CaseTemplate

  using do
    quote do
      use PhoenixBoilerplateWeb.ConnCase
      use PhoenixIntegration
    end
  end
end
