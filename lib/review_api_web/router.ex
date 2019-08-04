defmodule ReviewApiWeb.Router do
  use ReviewApiWeb, :router

  pipeline :api do
    plug :accepts, ["json"]
  end

  scope "/api", ReviewApiWeb do
    pipe_through :api
  end
end
