# frozen_string_literal: true

ActiveAdmin.register Essay do
  menu parent: "Questions"
  permit_params :answer_min_length, :answer_max_length, question_attributes: [:title, category_ids: []]

  index do
    selectable_column
    id_column
    column :question
    column :categories do |essay|
      essay.categories.map(&:name).join(", ")
    end
    column :answer_min_length
    column :answer_max_length
    actions
  end

  show do
    attributes_table do
      row :id
      row :question
      row :categories do |essay|
        essay.categories.map(&:name).join(", ")
      end
      row :answer_min_length
      row :answer_max_length
      row :created_at
      row :updated_at
    end
  end

  action_item :preview, only: :show do
    link_to("Preview", "/preview-question/#{essay.question.id}")
  end

  filter :categories, collection: lambda {
    Category.all.map { |category| [category.name, category.id] }
  }

  form do |f|
    f.inputs for: [:question, @resource.question || Question.new], builder: ActiveAdmin::FormBuilder do |ff|
      ff.input :title
      ff.input :categories
    end
    f.inputs do
      f.input :answer_min_length
      f.input :answer_max_length
    end
    f.actions
  end
end
