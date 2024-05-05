# == Schema Information
#
# Table name: tenants
#
#  id         :bigint(8)        not null, primary key
#  config     :json
#  domain     :string
#  name       :string
#  created_at :datetime         not null
#  updated_at :datetime         not null
#
class Tenant < ApplicationRecord
end
