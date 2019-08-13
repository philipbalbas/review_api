defmodule ReviewApiWeb.Schema.Types do
  use Absinthe.Schema.Notation

  alias ReviewApiWeb.Schema.Types

  import_types(Types.OrganizationType)
  import_types(Types.UserType)
end
