# frozen_string_literal: true

ActiveAdmin.register Interview do
  includes :interviews_categories, :categories
  permit_params :name, :config, category_ids: []
  json_editor

  index do
    selectable_column
    id_column
    column :name
    column :config
    column :categories do |interview|
      interview.categories.map(&:name).join(", ")
    end
    actions
  end

  show do
    attributes_table do
      row :id
      row :name
      row :config
      row :categories do |interview|
        interview.categories.map(&:name).join(", ")
      end
      row :created_at
      row :updated_at
    end
  end

  filter :categories, collection: lambda {
    Category.all.map { |category| [category.name, category.id] }
  }

  form do |f|
    f.inputs do
      f.input :name
      f.input :config, as: :jsonb
      f.input :categories
    end
    f.actions
  end
end
