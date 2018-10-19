# frozen_string_literal: true

module QuestionConcern
  extend ActiveSupport::Concern

  included do
    helper_method :question_json, :question_details
  end

  def question_details(question)
    details = {}
    questionable = question.questionable
    if questionable.is_a?(Essay)
      details.merge!(questionable.attributes)
    elsif questionable.is_a?(Mcq)
      markdown = Redcarpet::Markdown.new(Redcarpet::Render::HTML, tables: true)
      details[:options] = questionable.options.map do |option|
        markdown.render(option)
      end
    end
    details
  end

  def question_json(question)
    {
      id: question.id,
      type: question.questionable_type,
      title: question.title
    }
  end
end
