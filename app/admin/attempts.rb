# frozen_string_literal: true

ActiveAdmin.register Attempt do
  permit_params :interview_id, :interviewee_id
  json_editor

  index do
    selectable_column
    id_column
    column :interview
    column :interviewee
    actions
  end

  show do
    attributes_table do
      row :id
      row :interview
      row :interviewee
      row :response
      row :categories do |attempt|
        attempt.categories.map(&:name).join(", ")
      end
      row :questions do |attempt|
        attempt.questions.map(&:title).join(", ")
      end
      row :created_at
      row :updated_at
    end
  end

  filter :interview, collection: lambda {
    Interview.all.map { |interview| [interview.name, interview.id] }
  }

  filter :interviewee

  form do |f|
    f.inputs do
      f.input :interview
      f.input :interviewee
    end
    f.actions
  end
end
