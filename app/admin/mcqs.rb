# frozen_string_literal: true

ActiveAdmin.register Mcq do
  menu parent: "Questions"
  json_editor
  permit_params options: [], question_attributes: [:title, category_ids: []], correct_options: []
  before_save do |mcq|
    mcq.options = mcq.options.reject(&:empty?)
    mcq.correct_options = mcq.correct_options.select { |m| m.is_a? Numeric }
  end

  index do
    selectable_column
    id_column
    column :question
    column :categories do |essay|
      essay.categories.map(&:name).join(", ")
    end
    actions
  end

  show do
    attributes_table do
      row :id
      row :question
      row :categories do |essay|
        essay.categories.map(&:name).join(", ")
      end
      row :created_at
      row :updated_at
    end
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
      f.input :options, as: :array, class: "codemirror-array", item_class: "codemirror-item"
      f.input :correct_options, as: :array
    end
    f.actions
  end
end
