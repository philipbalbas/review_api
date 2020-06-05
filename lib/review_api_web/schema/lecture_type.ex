defmodule ReviewApiWeb.Schema.Types.LectureType do
  use Absinthe.Schema.Notation
  use Absinthe.Relay.Schema.Notation, :modern
  import Absinthe.Resolution.Helpers, only: [dataloader: 3, dataloader: 1]
  alias ReviewApi.{Lecture, Tests}

  node object(:category) do
    field :description, non_null(:string)
    field :name, non_null(:string)

    field :exams, list_of(non_null(:exam)) do
      resolve(dataloader(Tests, :exams, args: %{scope: :category}))
    end

    field :modules, list_of(non_null(:module)) do
      resolve(dataloader(Lecture, :modules, args: %{scope: :category}))
    end
  end

  node object(:module) do
    field(:name, non_null(:string))
    field(:description, non_null(:string))
    field(:category, non_null(:category), resolve: dataloader(Lecture))

    field(:subjects, list_of(non_null(:subject))) do
      resolve(dataloader(Lecture, :subjects, args: %{scope: :module}))
    end
  end

  node object(:subject) do
    field(:name, non_null(:string))
    field(:description, :string)
    field(:module, non_null(:module), resolve: dataloader(Lecture))

    field :topics, list_of(non_null(:topic)) do
      resolve(dataloader(Lecture, :topics, args: %{scope: :subject}))
    end
  end

  node object(:topic) do
    field(:name, non_null(:string))
    field(:content, :string)
    field(:description, :string)
    field(:subject, non_null(:subject), resolve: dataloader(Lecture))

    field :pages, list_of(non_null(:page)) do
      resolve(dataloader(Lecture, :pages, args: %{scope: :topic}))
    end

    field :cards, list_of(non_null(:card)) do
      resolve(dataloader(Tests, :cards, args: %{scope: :topic}))
    end
  end

  node object(:page) do
    field(:name, non_null(:string))
    field(:description, :string)
    field(:content, :string)
    field(:topic, non_null(:topic), resolve: dataloader(Lecture))

    field :notes, list_of(non_null(:note)) do
      resolve(dataloader(Lecture, :notes, args: %{scope: :page}))
    end
  end

  node object(:note) do
    field(:name, non_null(:string))
    field(:content, :string)
    field(:description, :string)
    field(:page, non_null(:page), resolve: dataloader(Lecture))
  end

  input_object :category_input_create do
    field(:name, non_null(:string))
    field(:description, non_null(:string))
  end

  input_object :category_input_update do
    field(:id, non_null(:id))
    field(:name, :string)
    field(:description, :string)
  end

  input_object :module_input do
    field(:name, non_null(:string))
    field(:description, non_null(:string))
    field(:category_id, non_null(:id))
  end

  input_object :module_input_update do
    field(:id, non_null(:id))
    field(:name, :string)
    field(:description, :string)
    field(:category_id, :id)
  end

  input_object :subject_create_input do
    field(:name, non_null(:string))
    field(:description, :string)
    field(:module_id, non_null(:id))
  end

  input_object :subject_update_input do
    field(:id, non_null(:id))
    field(:module_id, :id)
    field(:name, :string)
    field(:description, :string)
  end

  input_object :topic_create_input do
    field(:name, non_null(:string))
    field(:description, :string)
    field(:content, :string)
    field(:subject_id, non_null(:id))
  end

  input_object :topic_update_input do
    field(:id, non_null(:id))
    field(:subject_id, :id)
    field(:name, :string)
    field(:description, :string)
  end

  input_object :topics_filter do
    field(:subject_id, type: :id)
    field(:module_id, type: :id)
    field(:category_id, type: :id)
    field(:order, type: :sort_order, default_value: :asc)
  end

  input_object :page_create_input do
    field(:name, non_null(:string))
    field(:description, :string)
    field(:content, :string)
    field(:topic_id, non_null(:id))
  end

  input_object :page_update_input do
    field(:id, non_null(:id))
    field(:name, :string)
    field(:description, :string)
    field(:content, :string)
  end

  input_object :note_create_input do
    field(:name, non_null(:string))
    field(:description, :string)
    field(:content, :string)
    field(:page_id, non_null(:id))
  end

  input_object :note_update_input do
    field(:id, non_null(:id))
    field(:name, :string)
    field(:content, :string)
    field(:page_id, :id)
  end
end
