# frozen_string_literal: true

module Api
  module V1
    class AuthController < ApiController
      skip_before_action :authenticate_user_from_token!, only: :login

      def login
        if !params[:email] || !params[:auth_code]
          return _unprocessable_data
        end

        client_id = params[:client_id] || "web"
        email = params[:email]
        auth_code = params[:auth_code]
        ttl = params[:ttl] || DEFAULT_TOKEN_TTL
        user = User.find_by(email: email)
        return _not_authorized unless user

        interviewee = Interviewee.includes(:user).find_by(auth_code: auth_code)
        return _not_authorized unless interviewee
        return _not_authorized unless interviewee.user == user

        sign_out current_user
        sign_in(:user, user)
        render json: User.create_token(client_id, user.id, ttl).merge(user_json)
      end

      def logout
        expire_current_token
        sign_out current_user
        render json: { message: "Logged out." }
      end

      def whoami
        render json: user_json
      end

      private

      def expire_current_token
        given_token = request.headers["X-AUTH-TOKEN"]
        find_auth_token(given_token).update_attribute(:expires, DateTime.now) if given_token
      end

      def user_json
        u = current_user
        {
          id: u.id,
          first_name: u.first_name,
          last_name: u.last_name
        }
      end
    end
  end
end
