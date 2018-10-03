# frozen_string_literal: true

ActiveAdmin.register Attempt do
  permit_params :exam_id, :interviewee_id
  json_editor

  index do
    selectable_column
    id_column
    column :exam
    column :interviewee
    actions
  end

  show do
    attributes_table do
      row :id
      row :exam
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

  filter :exam, collection: lambda {
    Exam.all.map { |exam| [exam.name, exam.id] }
  }

  filter :interviewee

  form do |f|
    f.inputs do
      f.input :exam
      f.input :interviewee
    end
    f.actions
  end
end
