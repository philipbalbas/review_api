defmodule ReviewApiWeb.Router do
  use ReviewApiWeb, :router

  pipeline :api do
    plug :accepts, ["json"]
    plug ReviewApi.Plugs.SetCurrentUser
  end

  scope "/" do
    pipe_through :api

    forward("/api", Absinthe.Plug, schema: ReviewApiWeb.Schema)

    forward("/graphiql", Absinthe.Plug.GraphiQL, schema: ReviewApiWeb.Schema)
  end
end
