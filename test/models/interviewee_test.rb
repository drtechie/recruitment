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

require 'test_helper'

class IntervieweeTest < ActiveSupport::TestCase
  # test "the truth" do
  #   assert true
  # end
end
