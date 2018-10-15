# frozen_string_literal: true

module Api
  module V1
    class AttemptsController < ApiController
      before_action :set_attempt, only: %i(show start next_question)
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
        params[:category_ids].each do |id|
          AttemptsCategories.create(attempt_id: @attempt.id, category_id: id)
        end
        @attempt.transition_to!(:in_progress)
        render json: { attempt: attempt_json(@attempt) }
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
    end
  end
end
