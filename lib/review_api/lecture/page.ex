defmodule ReviewApi.Lecture.Page do
  use Ecto.Schema
  import Ecto.Changeset
  alias ReviewApi.Lecture.Topic

  schema "pages" do
    field :completed, :boolean, default: false
    field :content, :string
    field :description, :string
    field :name, :string

    belongs_to(:topic, Topic)

    timestamps()
  end

  @doc false
  def changeset(page, attrs) do
    page
    |> cast(attrs, [:name, :description, :completed, :content])
    |> validate_required([:name, :description, :completed, :content])
  end
end
