# frozen_string_literal: true

ActiveAdmin.register Interviewee do
  permit_params :user_id

  index do
    selectable_column
    id_column
    column :user
    column :auth_code
    actions
  end

  show do
    attributes_table do
      row :id
      row :user
      row :auth_code
      row :created_at
      row :updated_at
    end
  end

  filter :user, collection: lambda {
    User.all.map { |user| [user.full_name, user.id] }
  }

  form do |f|
    f.inputs do
      f.input :user, as: :select, collection: User.all
    end
    f.actions
  end
end
