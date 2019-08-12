defmodule ReviewApi.Lecture.Topic do
  use Ecto.Schema
  import Ecto.Changeset
  alias ReviewApi.Lecture.Subject

  schema "topics" do
    field :completed, :boolean, default: false
    field :content, :string
    field :description, :string
    field :name, :string

    belongs_to(:subject, Subject)

    timestamps()
  end

  @doc false
  def changeset(topic, attrs) do
    topic
    |> cast(attrs, [:name, :description, :completed, :content])
    |> validate_required([:name, :description, :completed, :content])
  end
end
