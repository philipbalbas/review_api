defmodule ReviewApiWeb.Schema.Middleware.Authenticate do
  @behaviour Absinthe.Middleware

  def call(resolution, _) do
    case resolution.context do
      %{current_user: _} ->
        resolution

      _ ->
        resolution |> Absinthe.Resolution.put_result({:error, "Please sigin in first!"})
    end
  end
end
