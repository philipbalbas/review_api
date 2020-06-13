defmodule ReviewApiWeb.Schema do
  use Absinthe.Schema
  use Absinthe.Relay.Schema, :modern
  alias Absinthe.Relay.Node.ParseIDs
  alias ReviewApiWeb.Resolvers
  import_types(ReviewApiWeb.Schema.Types)

  alias ReviewApi.{Accounts, Lecture, Tests}

  node interface do
    resolve_type(fn
      %ReviewApi.Accounts.Organization{}, _ ->
        :organization

      %ReviewApi.Accounts.User{}, _ ->
        :user

      %ReviewApi.Lecture.Category{}, _ ->
        :category

      %ReviewApi.Lecture.Module{}, _ ->
        :module

      %ReviewApi.Lecture.Subject{}, _ ->
        :subject

      %ReviewApi.Lecture.Topic{}, _ ->
        :topic

      %ReviewApi.Lecture.Page{}, _ ->
        :page

      %ReviewApi.Lecture.Note{}, _ ->
        :note

      %ReviewApi.Tests.Exam{}, _ ->
        :exam

      %ReviewApi.Tests.Card{}, _ ->
        :card

      %ReviewApi.Tests.Choice{}, _ ->
        :choice

      _, _ ->
        nil
    end)
  end

  query do
    node field do
      resolve(fn
        %{type: :organization, id: local_id}, _ ->
          {:ok, ReviewApi.Repo.get(ReviewApi.Accounts.Organization, local_id)}

        %{type: :user, id: local_id}, _ ->
          {:ok, ReviewApi.Repo.get(ReviewApi.Accounts.User, local_id)}

        %{type: :category, id: local_id}, _ ->
          {:ok, ReviewApi.Repo.get(ReviewApi.Lecture.Category, local_id)}

        %{type: :module, id: local_id}, _ ->
          {:ok, ReviewApi.Repo.get(ReviewApi.Lecture.Module, local_id)}

        %{type: :subject, id: local_id}, _ ->
          {:ok, ReviewApi.Repo.get(ReviewApi.Lecture.Subject, local_id)}

        %{type: :topic, id: local_id}, _ ->
          {:ok, ReviewApi.Repo.get(ReviewApi.Lecture.Topic, local_id)}

        %{type: :page, id: local_id}, _ ->
          {:ok, ReviewApi.Repo.get(ReviewApi.Lecture.Page, local_id)}

        %{type: :note, id: local_id}, _ ->
          {:ok, ReviewApi.Repo.get(ReviewApi.Lecture.Note, local_id)}

        %{type: :exam, id: local_id}, _ ->
          {:ok, ReviewApi.Repo.get(ReviewApi.Tests.Exam, local_id)}

        %{type: :card, id: local_id}, _ ->
          {:ok, ReviewApi.Repo.get(ReviewApi.Tests.Card, local_id)}

        %{type: :choice, id: local_id}, _ ->
          {:ok, ReviewApi.Repo.get(ReviewApi.Tests.Choice, local_id)}

        _, _ ->
          {:error, "Unknown node"}
      end)
    end

    @desc "Get a list of organizations"
    field :list_organizations, list_of(:organization) do
      resolve(&Resolvers.Accounts.list_organizations/3)
    end

    @desc "Get an organization"
    field :get_organization, :organization do
      arg(:id, non_null(:id))

      middleware(ParseIDs, id: :organization)
      resolve(&Resolvers.Accounts.get_organization/2)
    end

    @desc "Get a list of users"
    field :users, list_of(:user) do
      resolve(&Resolvers.Accounts.list_users/3)
    end

    @desc "Get a user"
    field :user, :user do
      arg(:id, non_null(:id))

      middleware(ParseIDs, id: :user)
      resolve(&Resolvers.Accounts.get_user/2)
    end

    @desc "Get a list of categories"
    field :list_categories, list_of(non_null(:category)) do
      resolve(&Resolvers.Lecture.list_categories/3)
    end

    @desc "Get a single category"
    field :get_category, :category do
      arg(:id, non_null(:id))

      middleware(ParseIDs, id: :category)
      resolve(&Resolvers.Lecture.get_category/2)
    end

    @desc "Get a list of modules"
    field :list_modules, list_of(non_null(:module)) do
      arg(:filter, :module_filter)

      middleware(ParseIDs,
        filter: [category_id: :category]
      )

      resolve(&Resolvers.Lecture.list_modules/3)
    end

    @desc "Get a single module"
    field :get_module, :module do
      arg(:id, non_null(:id))

      middleware(ParseIDs, id: :module)
      resolve(&Resolvers.Lecture.get_module/2)
    end

    @desc "Get a list subjects"
    field :list_subjects, list_of(non_null(:subject)) do
      arg(:filter, :subjects_filter)

      middleware(ParseIDs,
        filter: [module_id: :module, category_id: :category]
      )

      resolve(&Resolvers.Lecture.list_subjects/3)
    end

    @desc "Get a single subject"
    field :get_subject, :subject do
      arg(:id, non_null(:id))

      middleware(ParseIDs, id: :subject)
      resolve(&Resolvers.Lecture.get_subject/2)
    end

    @desc "Get a list topics"
    field :list_topics, list_of(non_null(:topic)) do
      arg(:filter, :topics_filter)

      middleware(ParseIDs,
        filter: [subject_id: :subject, module_id: :module, category_id: :category]
      )

      resolve(&Resolvers.Lecture.list_topics/3)
    end

    @desc "Get a single topic"
    field :get_topic, :topic do
      arg(:id, non_null(:id))

      middleware(ParseIDs, id: :topic)
      resolve(&Resolvers.Lecture.get_topic/2)
    end

    @desc "Get a list of pages"
    field :list_pages, list_of(:page) do
      arg(:topic_id, type: :id)
      arg(:order, type: :sort_order, default_value: :asc)

      middleware(ParseIDs, topic_id: :topic)
      resolve(&Resolvers.Lecture.list_pages/3)
    end

    @desc "Get a single page"
    field :get_page, :page do
      arg(:id, non_null(:id))

      middleware(ParseIDs, id: :page)
      resolve(&Resolvers.Lecture.get_page/2)
    end

    @desc "Get a list of notes"
    field :list_notes, list_of(:note) do
      arg(:page_id, type: :id)
      arg(:order, type: :sort_order, default_value: :asc)

      middleware(ParseIDs, page_id: :page)
      resolve(&Resolvers.Lecture.list_notes/3)
    end

    @desc "Get a single note"
    field :get_note, :note do
      arg(:id, non_null(:id))

      middleware(ParseIDs, id: :note)
      resolve(&Resolvers.Lecture.get_note/2)
    end

    @desc "Get a list of exams"
    field :list_exams, list_of(non_null(:exam)) do
      arg(:filter, :exam_filter)

      middleware(ParseIDs, filter: [category_id: :category])
      resolve(&Resolvers.Tests.list_exams/3)
    end

    @desc "Get a single exam"
    field :get_exam, :exam do
      arg(:id, non_null(:id))

      middleware(ParseIDs, id: :exam)
      resolve(&Resolvers.Tests.get_exam/2)
    end

    @desc "Get a list of cards"
    field :list_cards, list_of(non_null(:card)) do
      arg(:filter, :card_filter)

      middleware(ParseIDs,
        filter: [topic_id: :topic, exam_id: :exam, category_id: :category]
      )

      resolve(&Resolvers.Tests.list_cards/3)
    end

    @desc "Get a list of choices"
    field :list_choices, list_of(non_null(:choice)) do
      arg(:filter, :choice_filter)
      resolve(&Resolvers.Tests.list_choices/3)
    end

    field :get_choice, :choice do
      arg(:id, non_null(:id))
      resolve(&Resolvers.Tests.get_choice/2)
    end
  end

  mutation do
    @desc "Create an organization"
    payload field :create_organization do
      input do
        field :input_data, non_null(:organization_input)
      end

      output do
        field :result, :organization
      end

      resolve(&Resolvers.Accounts.create_organization/3)
    end

    @desc "Signin a user"
    field :signin, :session do
      arg(:email, :string)
      arg(:password, :string)
      resolve(&Resolvers.Accounts.signin/3)
    end

    @desc "Signup a user"
    field :signup, :user do
      arg(:input, non_null(:user_input))
      resolve(&Resolvers.Accounts.signup/3)
    end

    @desc "Create a category"
    payload field :create_category do
      input do
        field :input_data, non_null(:category_input_create)
      end

      output do
        field :result, :category
      end

      resolve(&Resolvers.Lecture.create_category/3)
    end

    @desc "Update a category"
    payload field :update_category do
      input do
        field :input_data, non_null(:category_input_update)
      end

      output do
        field :result, :category
      end

      resolve(&Resolvers.Lecture.update_category/3)
    end

    @desc "Create a module"
    payload field :create_module do
      input do
        field :input_data, non_null(:module_input)
      end

      output do
        field :result, :module
      end

      resolve(&Resolvers.Lecture.create_module/3)
    end

    @desc "Update a module"
    payload field :update_module do
      input do
        field :input_data, non_null(:module_input_update)
      end

      output do
        field :result, :module
      end

      middleware(ParseIDs,
        input_data: [id: :module, category_id: :category]
      )

      resolve(&Resolvers.Lecture.update_module/3)
    end

    @desc "Create a subject"
    payload field :create_subject do
      input do
        field :input_data, non_null(:subject_create_input)
      end

      output do
        field :result, :subject
      end

      middleware(ParseIDs,
        input_data: [module_id: :module]
      )

      resolve(&Resolvers.Lecture.create_subject/3)
    end

    @desc "Update a subject"
    payload field :update_subject do
      input do
        field :input_data, non_null(:subject_update_input)
      end

      output do
        field :result, :subject
      end

      middleware(ParseIDs,
        input_data: [id: :subject]
      )

      resolve(&Resolvers.Lecture.update_subject/3)
    end

    @desc "Create a topic"
    payload field :create_topic do
      input do
        field :input_data, non_null(:topic_create_input)
      end

      output do
        field :result, :topic
      end

      middleware(ParseIDs,
        input_data: [subject_id: :subject]
      )

      resolve(&Resolvers.Lecture.create_topic/3)
    end

    @desc "Update a topic"
    payload field :update_topic do
      input do
        field :input_data, non_null(:topic_update_input)
      end

      output do
        field :result, :topic
      end

      middleware(ParseIDs,
        input_data: [id: :topic]
      )

      resolve(&Resolvers.Lecture.update_topic/3)
    end

    @desc "Create a page"
    payload field :create_page do
      input do
        field :input_data, non_null(:page_create_input)
      end

      output do
        field :result, :page
      end

      middleware(ParseIDs,
        input_data: [topic_id: :topic]
      )

      resolve(&Resolvers.Lecture.create_page/3)
    end

    @desc "Update a page"
    payload field :update_page do
      input do
        field :input, non_null(:page_update_input)
      end

      output do
        field :result, :page
      end

      middleware(ParseIDs,
        input_data: [id: :page]
      )

      resolve(&Resolvers.Lecture.update_page/3)
    end

    @desc "Create a note"
    payload field :create_note do
      input do
        field(:input_data, non_null(:note_create_input))
      end

      output do
        field :result, :note
      end

      middleware(ParseIDs,
        input_data: [page_id: :page]
      )

      resolve(&Resolvers.Lecture.create_note/3)
    end

    @desc "Update a note"
    payload field :update_note do
      input do
        field(:input_data, non_null(:note_update_input))
      end

      output do
        field :result, :note
      end

      middleware(ParseIDs,
        input_data: [id: :note]
      )

      resolve(&Resolvers.Lecture.update_note/3)
    end

    @desc "Create an exam"
    payload field :create_exam do
      input do
        field(:input_data, non_null(:exam_create_input))
      end

      output do
        field :result, :exam
      end

      middleware(ParseIDs,
        input_data: [category_id: :category]
      )

      resolve(&Resolvers.Tests.create_exam/3)
    end

    @desc "Update an exam"
    payload field :update_exam do
      input do
        field(:input_data, non_null(:exam_update_input))
      end

      output do
        field :result, :exam
      end

      middleware(ParseIDs,
        input_data: [id: :exam]
      )

      resolve(&Resolvers.Tests.update_exam/3)
    end

    @desc "Create a card"
    payload field :create_card do
      input do
        field(:input_data, non_null(:card_create_input))
      end

      output do
        field(:result, :card)
      end

      middleware(ParseIDs, input_data: [topic_id: :topic])

      resolve(&Resolvers.Tests.create_card/3)
    end

    @desc "Create a choice"
    payload field :create_choice do
      input do
        field(:input_data, non_null(:choice_create_input))
      end

      output do
        field(:result, :choice)
      end

      resolve(&Resolvers.Tests.create_choice/3)
    end

    @desc "Add choices to card"
    payload field :upsert_card_choices do
      input do
        field(:input_data, non_null(:card_choices_upsert_input))
      end

      output do
        field(:result, :card)
      end

      middleware(ParseIDs, input_data: [card_id: :card, choice_ids: :choice])
      resolve(&Resolvers.Tests.upsert_card_choices/3)
    end

    @desc "Add answers to question"
    payload field :upsert_question_answers do
      input do
        field(:input_data, non_null(:question_answers_upsert_input))
      end

      output do
        field(:result, :card)
      end

      middleware(ParseIDs, input_data: [card_id: :card, choice_ids: :choice])
      resolve(&Resolvers.Tests.upsert_question_answers/3)
    end

    @desc "Add cards to exam"
    payload field :upsert_exam_cards do
      input do
        field(:input_data, non_null(:exam_cards_upsert_input))
      end

      output do
        field(:result, :exam)
      end

      middleware(ParseIDs, input_data: [exam_id: :exam, card_ids: :card])
      resolve(&Resolvers.Tests.upsert_exam_cards/3)
    end

    @desc "Add cards to exam"
    payload field :upsert_card_exams do
      input do
        field(:input_data, non_null(:card_exams_upsert_input))
      end

      output do
        field(:result, :card)
      end

      middleware(ParseIDs, input_data: [card_id: :card, exam_ids: :exam])
      resolve(&Resolvers.Tests.upsert_card_exams/3)
    end
  end

  enum :sort_order do
    value(:asc)
    value(:desc)
  end

  def context(ctx) do
    loader =
      Dataloader.new()
      |> Dataloader.add_source(Accounts, Accounts.datasource())
      |> Dataloader.add_source(Lecture, Lecture.datasource())
      |> Dataloader.add_source(Tests, Tests.datasource())

    Map.put(ctx, :loader, loader)
  end

  def plugins do
    [Absinthe.Middleware.Dataloader] ++ Absinthe.Plugin.defaults()
  end
end
