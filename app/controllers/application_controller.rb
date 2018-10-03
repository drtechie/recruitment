# frozen_string_literal: true

class ApplicationController < ActionController::Base
  def access_denied(exception)
    respond_to do |format|
      format.json { head :forbidden, content_type: "text/html" }
      format.html { redirect_to root_url, notice: exception.message }
      format.js   { head :forbidden, content_type: "text/html" }
    end
  end
end
