defmodule ReviewApiWeb.Schema.Types.LectureType do
  use Absinthe.Schema.Notation
  import Absinthe.Resolution.Helpers, only: [dataloader: 1, dataloader: 3]
  alias ReviewApi.Lecture

  object :module do
    field(:id, :id)
    field(:name, :string)
    field(:description, :string)
    field :subjects, list_of(:subject), resolve: dataloader(Lecture)
  end

  object :subject do
    field(:id, :id)
    field(:name, :string)
    field(:description, :string)
    field :topics, list_of(:topic), resolve: dataloader(Lecture)
  end

  object :topic do
    field(:id, :id)
    field(:name, :string)
    field(:content, :string)
    field(:description, :string)
    field :pages, list_of(:page), resolve: dataloader(Lecture)
  end

  object :page do
    field(:id, :id)
    field(:name, :string)
    field(:content, :string)
    field(:description, :string)
    field :notes, list_of(:note), resolve: dataloader(Lecture)
  end

  object :note do
    field(:id, :id)
    field(:name, :string)
    field(:content, :string)
    field(:description, :string)
  end

  input_object :module_input do
    field(:name, non_null(:string))
    field(:description, :string)
  end

  input_object :subject_input do
    field(:name, non_null(:string))
    field(:description, :string)
    field(:module_id, non_null(:id))
  end

  input_object :topic_input do
    field(:name, non_null(:string))
    field(:description, :string)
    field(:content, :string)
    field(:subject_id, non_null(:id))
  end

  input_object :page_input do
    field(:name, non_null(:string))
    field(:description, :string)
    field(:content, :string)
    field(:topic_id, non_null(:id))
  end

  input_object :note_input do
    field(:name, non_null(:string))
    field(:description, :string)
    field(:content, :string)
    field(:page_id, non_null(:id))
  end

  input_object :update_page_input do
    field(:id, non_null(:id))
    field(:name, :string)
    field(:content, :string)
    field(:topic_id, :id)
  end

  input_object :update_note_input do
    field(:id, non_null(:id))
    field(:name, :string)
    field(:content, :string)
    field(:page_id, :id)
  end
end
