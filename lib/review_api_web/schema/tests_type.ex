defmodule ReviewApiWeb.Schema.Types.TestsType do
  use Absinthe.Schema.Notation
  use Absinthe.Relay.Schema.Notation, :modern
  import Absinthe.Resolution.Helpers, only: [dataloader: 1, dataloader: 3]
  alias ReviewApi.{Tests, Lecture}

  enum :exam_type do
    value(:practice, as: "practice", description: "Practice Test")
    value(:comprehensive, as: "comprehensive", description: "Comprehensive Exam")
    value(:mock, as: "mock", description: "Mock Exam")
  end

  enum :card_type do
    value(:single, as: "single", description: "Single Answer")
    value(:multiple, as: "multiple", description: "Multiple Answers")
  end

  enum :card_level do
    value(:remember, as: "remember")
    value(:understand, as: "understand")
    value(:apply, as: "apply")
    value(:analyse, as: "analyse")
    value(:evaluate, as: "evaluate")
    value(:create, as: "create")
  end

  node object(:exam) do
    field :name, non_null(:string)
    field :type, non_null(:exam_type)
    field :description, non_null(:string)
    field :order, :integer
    field(:category, non_null(:category), resolve: dataloader(Lecture))

    field :cards, list_of(non_null(:card)) do
      resolve(dataloader(Tests, :cards, args: %{scope: :exam}))
    end

    field :topics, list_of(non_null(:topic)) do
      resolve(dataloader(Lecture, :topics, args: %{scope: :topic}))
    end
  end

  node object(:card) do
    field :question, non_null(:string)
    field :rationale, :string
    field :type, non_null(:card_type)
    field :level, non_null(:card_level)
    field :choices, list_of(non_null(:choice)), resolve: dataloader(Tests)
    field :answers, list_of(non_null(:choice)), resolve: dataloader(Tests)
    field :exams, list_of(non_null(:exam)), resolve: dataloader(Tests)
    field :topic, non_null(:topic), resolve: dataloader(Lecture)
  end

  node object(:choice) do
    field :content, non_null(:string)
    field :cards, list_of(non_null(:card)), resolve: dataloader(Tests)
  end

  input_object :card_filter do
    field :exam_id, :id
    field :topic_id, :id
    field :category_id, :id
    field :level, :card_level
  end

  input_object :exam_filter do
    field :category_id, :id
    field :type, :exam_type
  end

  input_object :choice_filter do
    field :card_id, :id
    field :search_term, :string
  end

  input_object :exam_create_input do
    field :name, non_null(:string)
    field :type, non_null(:exam_type)
    field :order, :integer
    field :description, non_null(:string)
    field :category_id, non_null(:id)
  end

  input_object :exam_update_input do
    field :id, non_null(:id)
    field :name, :string
    field :type, :exam_type
    field :order, :integer
    field :description, :string
  end

  input_object :card_create_input do
    field :question, non_null(:string)
    field :rationale, :string
    field :type, non_null(:card_type)
    field :level, non_null(:card_level)
    field :topic_id, non_null(:id)
  end

  input_object :card_update_input do
    field :id, non_null(:id)
    field :question, :string
    field :rationale, :string
    field :type, :card_type
    field :level, :card_level
    field :topic_id, :id
  end

  input_object :choice_create_input do
    field :content, non_null(:string)
  end

  input_object :choice_update_input do
    field :id, non_null(:id)
    field :content, non_null(:string)
  end

  input_object :card_choices_upsert_input do
    field :card_id, non_null(:id)
    field :choice_ids, non_null(list_of(non_null(:id)))
  end

  input_object :card_answers_upsert_input do
    field :card_id, non_null(:id)
    field :answer_ids, non_null(list_of(non_null(:id)))
  end

  input_object :question_answers_upsert_input do
    field :card_id, non_null(:id)
    field :choice_ids, non_null(list_of(:id))
  end

  input_object :exam_cards_upsert_input do
    field :exam_id, non_null(:id)
    field :card_ids, non_null(list_of(non_null(:id)))
  end

  input_object :card_exams_upsert_input do
    field :card_id, non_null(:id)
    field :exam_ids, non_null(list_of(non_null(:id)))
  end

  input_object :exam_topics_upsert_input do
    field :exam_id, non_null(:id)
    field :topic_ids, non_null(list_of(non_null(:id)))
  end
end
