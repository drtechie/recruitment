# frozen_string_literal: true

ActiveAdmin.register Attempt do
  includes :interviewee, :interview
  permit_params :interview_id, :interviewee_id
  json_editor

  index do
    selectable_column
    id_column
    column :interview
    column :interviewee
    column :current_state
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
      row :created_at
      row :updated_at
      row :started_at
      row :ended_at
    end
    render partial: "show", locals: { attempt: attempt }
  end

  controller do
    def show
      questions = resource.response&.dig("answers")&.map do |ans|
        Question.includes(:questionable).find_by(id: ans.keys[0])
      end
      @indexed_questions = questions&.index_by(&:id) || []
      super
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
