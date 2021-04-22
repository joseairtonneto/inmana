defmodule Inmana.Supplies.Create do
  alias Inmana.{Repo, Restaurant, Supply}

  def call(params) do
    uuid = params["restaurant_id"]

    case Ecto.UUID.cast(uuid) do
      :error -> {:error, %{result: "Is invalid id", status: :bad_request}}
      {:ok, uuid} -> create(params, uuid)
    end
  end

  def create(params, uuid) do
    case Repo.get(Restaurant, uuid) do
      nil ->
        {:error, %{result: "Restaurant not found", status: :bad_request}}

      _restaurant ->
        params
        |> Supply.changeSet()
        |> Repo.insert()
        |> handle_insert()
    end
  end

  defp handle_insert({:ok, %Supply{}} = result), do: result
  defp handle_insert({:error, result}), do: {:error, %{result: result, status: :bad_request}}
end
