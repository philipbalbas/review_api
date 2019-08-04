defmodule ReviewApi.Lecture.Module do
  use Ecto.Schema
  import Ecto.Changeset

  schema "modules" do
    field :completed, :boolean, default: false
    field :description, :string
    field :name, :string

    timestamps()
  end

  @doc false
  def changeset(module, attrs) do
    module
    |> cast(attrs, [:name, :description, :completed])
    |> validate_required([:name, :description, :completed])
  end
end
