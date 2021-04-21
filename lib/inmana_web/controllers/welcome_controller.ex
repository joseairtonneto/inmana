defmodule InmanaWeb.WelcomeController do
  use InmanaWeb, :controller

  alias Inmana.Welcomer

  def index(conn, params) do
    params
    |>  Welcomer.welcome()
    |>  handle_response(conn)
  end

  defp handle_response({:ok, message}, conn), do: render_response(message, conn, :ok)

  defp handle_response({:error, message}, conn), do: render_response(message, conn, :bad_request)

  defp render_response(message, conn, status) do
    conn
    |>  put_status(status)
    |>  json(%{message: message})
  end
end
