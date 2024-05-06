# frozen_string_literal: true

require "#{Rails.root}/lib/next_question_fetcher"
module Api
  module V1
    class EventsController < ApiController
      def create
        @attempt = Attempt.find(params[:attempt_id])
        @interviewee = @attempt.interviewee
        unless current_user.interviewee == @interviewee
          render json: { error: 'Forbidden' }, status: :forbidden
          return
        end

        @event = @attempt.events.build(event_params)

        if @event.save
          render json: @event, status: :created
        else
          render json: @event.errors, status: :unprocessable_entity
        end
      end

      private
      def event_params
        params.require(:event).permit(:name, params: {})
      end
    end
  end
end
