defmodule ReviewApi.Lecture.Note do
  use Ecto.Schema
  import Ecto.Changeset
  alias ReviewApi.Lecture.Page

  schema "notes" do
    field :completed, :boolean, default: false
    field :content, :string
    field :description, :string
    field :name, :string

    belongs_to(:page, Page)

    timestamps()
  end

  @doc false
  def changeset(note, attrs) do
    note
    |> cast(attrs, [:name, :description, :completed, :content])
    |> validate_required([:name, :description, :completed, :content])
  end
end
