# frozen_string_literal: true

module Api
  module V1
    # API routes extend from this controller
    class ApiController < ApplicationController
      skip_before_action :verify_authenticity_token
      before_action :authenticate_user_from_token!

      def ping
        render json: { message: "pong" }
      end
    end
  end
end
