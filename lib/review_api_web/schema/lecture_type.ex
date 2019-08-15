defmodule ReviewApiWeb.Schema.Types.LectureType do
  use Absinthe.Schema.Notation

  object :module do
    field(:id, :id)
    field(:name, :string)
    field(:description, :string)
  end

  input_object :module_input do
    field(:name, non_null(:string))
    field(:description, :string)
  end
end
