# frozen_string_literal: true

module Api
  module V1
    class AttemptsController < ApiController
      def index
        attempts = current_user.interviewee.attempts.includes(interview: [:categories])
        render json: { attempts: attempts.map do |attempt|
          {
            id: attempt.id,
            intreview_name: attempt.interview.name,
            categories: attempt.interview.categories.map do |category|
                          { id: category.id, name: category.name, parent_id: category.parent_id }
                        end,
            current_state: attempt.current_state
          }
        end }
      end

      def show
        render json: { message: "Logged out." }
      end
    end
  end
end
