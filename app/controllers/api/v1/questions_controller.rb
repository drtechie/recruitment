# frozen_string_literal: true

require "#{Rails.root}/lib/next_question_fetcher"
module Api
  module V1
    class QuestionsController < ApiController
      include QuestionConcern
      before_action :set_question, only: %i(preview)
      def preview
        preview_question = {}
        details = question_details(@question)
        preview_question = preview_question.merge(question_json(@question)).merge(details: details)
        render json: { question: preview_question }
      end

      private

      def set_question
        unless params[:question_id]
          return _unprocessable_data
        end

        @question = Question.find_by(id: params[:question_id].to_i)
        unless @question
          _not_found
        end
      end
    end
  end
end
