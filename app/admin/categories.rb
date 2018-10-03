# frozen_string_literal: true

ActiveAdmin.register Category do
  permit_params :parent_id, :name

  index do
    selectable_column
    id_column
    column :name
    column :parent
    actions
  end

  show do
    attributes_table do
      row :id
      row :name
      row :parent
      row :created_at
      row :updated_at
    end
  end

  filter :parent, collection: lambda {
    Category.roots.map { |category| [category.name, category.id] }
  }

  form do |f|
    f.inputs do
      f.input :name
      f.input :parent, as: :select, collection: Category.all
    end
    f.actions
  end
end
