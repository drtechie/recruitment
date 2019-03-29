# frozen_string_literal: true

module ApplicationHelper
  def get_auth_token
    if current_user
      token = {}
      if request.cookies["authToken"]
        auth_token_cookie = JSON.parse(request.cookies["authToken"], quirks_mode: true)
        token[:token] = auth_token_cookie["token"]
        token[:expires] = auth_token_cookie["expires"]
      else
        token =  User.create_token("web", current_user.id)
      end
      token
    end
  end
end
