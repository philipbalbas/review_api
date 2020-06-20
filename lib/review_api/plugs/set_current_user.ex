defmodule ReviewApi.Plugs.SetCurrentUser do
  @behaviour Plug

  import Plug.Conn

  def init(opts), do: opts

  def call(conn, _) do
    context = build_context(conn)
    Absinthe.Plug.put_options(conn, context: context)
  end

  defp build_context(conn) do
    with ["Bearer " <> token] <- get_req_header(conn, "authorization"),
         {:ok, %{id: id}} <- ReviewApiWeb.AuthToken.verify(token),
         %{} = user <- ReviewApi.Accounts.get_user!(id) do
      %{current_user: user}
    else
      _ -> %{}
    end
  end
end
