defmodule ReviewApiWeb.Schema.Types do
  use Absinthe.Schema.Notation

  alias ReviewApiWeb.Schema.Types

  import_types(Types.AccountsType)
  import_types(Types.LectureType)
  import_types(Types.TestsType)
end
