# frozen_string_literal: true

class HomeController < ApplicationController
  def index;
    current_domain = request.host
    @tenant = Tenant.find_by(domain: current_domain)

    if @tenant.nil?
      render plain: "Tenant not found for domain: #{current_domain}", status: :not_found
    else
      @config = @tenant.config
      @org_name = @tenant.name
    end
  end
end
