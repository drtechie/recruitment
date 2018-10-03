# frozen_string_literal: true

# == Schema Information
#
# Table name: interviewees
#
#  id         :bigint(8)        not null, primary key
#  auth_code  :string
#  created_at :datetime         not null
#  updated_at :datetime         not null
#  user_id    :bigint(8)
#
# Indexes
#
#  index_interviewees_on_user_id  (user_id)
#
# Foreign Keys
#
#  fk_rails_...  (user_id => users.id)
#

class Interviewee < ApplicationRecord
  belongs_to :user
  validates_presence_of :user_id

  before_save :set_auth_code

  def set_auth_code
    self.auth_code = ("A".."Z").to_a.sample(8).join if auth_code.nil?
  end

  def full_name
    user.full_name
  end
end
