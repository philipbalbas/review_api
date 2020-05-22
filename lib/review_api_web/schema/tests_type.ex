defmodule ReviewApiWeb.Schema.Types.TestsType do
  use Absinthe.Schema.Notation
  use Absinthe.Relay.Schema.Notation, :modern
  import Absinthe.Resolution.Helpers, only: [dataloader: 1, dataloader: 3]
  alias ReviewApi.Tests

  enum :exam_type do
    value(:practice, as: "practice", description: "Practice Test")
    value(:comprehensive, as: "comprehensive", description: "Comprehensive Exam")
    value(:mock, as: "mock", description: "Mock Exam")
  end

  enum :card_type do
    value(:single, as: "single", description: "Single Answer")
    value(:multiple, as: "multiple", description: "Multiple Answers")
  end

  node object(:exam) do
    field :name, non_null(:string)
    field :type, non_null(:exam_type)
    field :category_id, non_null(:id)
    field :description, non_null(:string)

    field :cards, list_of(:card) do
      resolve(dataloader(Tests, :cards, args: %{scope: :exam}))
    end
  end

  node object(:card) do
    field :question, non_null(:string)
    field :rationale, :string
    field :type, non_null(:card_type)
    field :exam_id, :id
    field :topic_id, :id
    field :choices, list_of(:choice), resolve: dataloader(Tests)
    field :answers, list_of(:choice), resolve: dataloader(Tests)
  end

  node object(:choice) do
    field :content, non_null(:string)
  end

  input_object :card_filter do
    field :exam_id, :id
    field :topic_id, :id
  end

  input_object :exam_filter do
    field :category_id, :id
    field :type, :exam_type
  end

  input_object :create_exam_input do
    field :name, non_null(:string)
    field :type, non_null(:exam_type)
    field :description, non_null(:string)
    field :category_id, non_null(:id)
  end

  input_object :update_exam_input do
    field :id, non_null(:id)
    field :name, :string
    field :type, :exam_type
    field :category_id, :id
  end

  input_object :create_card_input do
    field :question, non_null(:string)
    field :rationale, :string
    field :type, non_null(:card_type)
    field :topic_id, :id
    field :exam_id, :id
  end

  input_object :create_choice_input do
    field :content, non_null(:string)
    field :card_id, :id
  end

  input_object :upsert_card_choices_input do
    field :card_id, non_null(:id)
    field :choice_ids, non_null(list_of(:id))
  end

  input_object :upsert_question_answers_input do
    field :card_id, non_null(:id)
    field :choice_ids, non_null(list_of(:id))
  end

  input_object :upsert_exam_cards_input do
    field :exam_id, non_null(:id)
    field :card_ids, non_null(list_of(:id))
  end
end
