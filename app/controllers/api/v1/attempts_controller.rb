# frozen_string_literal: true

require "#{Rails.root}/lib/next_question_fetcher"
module Api
  module V1
    class AttemptsController < ApiController
      before_action :set_attempt, only: %i(show start next_question submit_answer)
      def index
        attempts = current_user.interviewee.attempts.includes(:interview)
        render json: { attempts: attempts.map do |attempt|
          attempt_json(attempt)
        end }
      end

      def show
        render json: { attempt: attempt_json(@attempt) }
      end

      def start
        unless params[:category_ids].blank?
          params[:category_ids].each do |id|
            AttemptsCategories.create(attempt_id: @attempt.id, category_id: id)
          end
          @attempt.transition_to!(:in_progress)
          return render json: { attempt: attempt_json(@attempt) }
        end
        _unprocessable_data
      end

      def next_question
        question_fetcher = NextQuestionFetcher.new
        next_question = question_fetcher.find_next_question(@attempt)
        question = {}
        if next_question.is_a?(Question)
          details = {}
          questionable = next_question.questionable
          if questionable.is_a?(Essay)
            details.merge!(questionable.attributes)
          elsif questionable.is_a?(Mcq)
            markdown = Redcarpet::Markdown.new(Redcarpet::Render::HTML, tables: true)
            details[:options] = questionable.options.map do |option|
              markdown.render(option)
            end
          end
          question = question.merge(question_json(next_question)).merge(details: details)
          # Assign the question to attempt
          attempt_question = AttemptsQuestions.find_by(attempt_id: @attempt.id, question_id: next_question.id)
          unless attempt_question
            AttemptsQuestions.create!(attempt_id: @attempt.id, question_id: next_question.id)
          end
          render json: { question: question }
        elsif next_question == "Completed"
          @attempt.transition_to!(:submitted)
          render json: { attempt: attempt_json(@attempt), message: "Interview completed. You will be contacted soon." }
        end
      end

      def submit_answer
        unless params[:answer]
          return _unprocessable_data
        end

        attempt_response = @attempt.response || {}
        answers = attempt_response&.dig("answers") || []
        question_id = params[:answer].keys[0]
        answered_question_index = answers.find_index { |a| a.keys[0] == question_id }
        if answered_question_index
          answers[answered_question_index] = params[:answer]
        else
          answers << params[:answer]
        end
        attempt_response["answers"] = answers
        @attempt.response = attempt_response
        @attempt.save!
        render json: { message: "Answer saved" }
      end

      private

      def set_attempt
        unless params[:attempt_id]
          return _unprocessable_data
        end

        @attempt = Attempt.find_by(id: params[:attempt_id])
        unless @attempt
          _not_found
        end
      end

      def attempt_json(attempt)
        {
          id: attempt.id,
          interview_name: attempt.interview.name,
          interview_categories: Category.get_tree(attempt.interview.categories),
          current_state: attempt.current_state
        }
      end

      def question_json(question)
        {
          id: question.id,
          type: question.questionable_type,
          title: question.title
        }
      end
    end
  end
end
