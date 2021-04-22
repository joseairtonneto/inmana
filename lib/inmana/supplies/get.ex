defmodule Inmana.Supplies.Get do
  alias Inmana.{Repo, Supply}

  def call(uuid) do
    case Ecto.UUID.cast(uuid) do
      :error -> {:error, %{result: "Is invalid id", status: :bad_request}}
      {:ok, uuid} -> get(uuid)
    end
  end

  def get(uuid) do
    case Repo.get(Supply, uuid) do
      nil -> {:error, %{result: "Supply not found", status: :not_found}}
      supply -> {:ok, supply}
    end
  end
end
