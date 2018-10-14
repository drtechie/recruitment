# frozen_string_literal: true

module Api
  module V1
    class AttemptsController < ApiController
      def index
        attempts = current_user.interviewee.attempts.includes(interview: [:categories])
        render json: { attempts: attempts.map do |attempt|
          attempt_json(attempt)
        end }
      end

      def show
        unless params[:attempt_id]
          return _unprocessable_data
        end

        attempt = Attempt.find_by(id: params[:attempt_id])
        unless attempt
          return _not_found
        end

        render json: { attempt: attempt_json(attempt) }
      end

      private

      def attempt_json(attempt)
        {
          id: attempt.id,
          interview_name: attempt.interview.name,
          interview_categories: Category.get_tree(attempt.interview.categories),
          current_state: attempt.current_state
        }
      end
    end
  end
end
