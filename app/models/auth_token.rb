# frozen_string_literal: true

# == Schema Information
#
# Table name: auth_tokens
#
#  id         :bigint(8)        not null, primary key
#  expires    :datetime
#  token      :string
#  created_at :datetime         not null
#  updated_at :datetime         not null
#  client_id  :string
#  user_id    :bigint(8)
#
# Indexes
#
#  index_auth_tokens_on_user_id                        (user_id)
#  index_auth_tokens_on_user_id_and_token_and_expires  (user_id,token,expires)
#
# Foreign Keys
#
#  fk_rails_...  (user_id => users.id)
#

class AuthToken < ApplicationRecord
  belongs_to :user
end
