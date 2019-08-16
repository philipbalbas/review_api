defmodule ReviewApiWeb.Schema.Types.LectureType do
  use Absinthe.Schema.Notation

  object :module do
    field(:id, :id)
    field(:name, :string)
    field(:description, :string)
  end

  object :subject do
    field(:id, :id)
    field(:name, :string)
    field(:description, :string)
  end

  object :topic do
    field(:id, :id)
    field(:name, :string)
    field(:content, :string)
    field(:description, :string)
  end

  object :page do
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
end
