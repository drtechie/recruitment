# frozen_string_literal: true

class ApplicationController < ActionController::Base
  def access_denied(exception)
    respond_to do |format|
      format.json { head :forbidden, content_type: "text/html" }
      format.html { redirect_to root_url, notice: exception.message }
      format.js   { head :forbidden, content_type: "text/html" }
    end
  end

  def authenticate_user_from_token!
    given_token = request.headers["X-AUTH-TOKEN"]
    if given_token
      token = find_auth_token(given_token)
      return _not_authorized unless token&.user

      sign_in token.user, store: false
    end
    false
  end

  def _not_authorized
    render json: { error: "You need to sign in or sign up before continuing." }, status: :unauthorized
  end

  def _cant_access_this_data
    render json: { error: "You do not have permission to access this data." }, status: :forbidden
  end

  def _unprocessable_data
    render json: { error: "Unprocessable data." },
           status: :unprocessable_data
  end

  private

  def find_auth_token(given_token)
    token_hash = Digest::SHA1.hexdigest given_token
    AuthToken.where("token = ? and expires >= ?", token_hash, Time.now.utc).first
  end
end
