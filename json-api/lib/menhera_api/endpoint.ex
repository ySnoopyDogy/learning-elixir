defmodule MenheraApi.Endpoint do
  use Plug.Router

  plug(:match)

  plug(Plug.Parsers,
    parsers: [:json],
    pass: ["application/json"],
    json_decoder: Poison
  )

  plug(:dispatch)

  forward("/api", to: MenheraApi.Router)

  match _ do
    send_resp(conn, 404, "Page not Found!")
  end

  def child_spec(opts) do
    %{
      id: __MODULE__,
      start: {__MODULE__, :star_link, [opts]}
    }
  end

  def star_link(_opts),
    do: Plug.Adapters.Cowboy2.http(__MODULE__, [])
end
