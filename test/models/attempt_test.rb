# == Schema Information
#
# Table name: attempts
#
#  id             :bigint(8)        not null, primary key
#  ended_at       :datetime
#  response       :jsonb
#  started_at     :datetime
#  created_at     :datetime         not null
#  updated_at     :datetime         not null
#  interview_id   :bigint(8)
#  interviewee_id :bigint(8)
#
# Indexes
#
#  index_attempts_on_interview_id    (interview_id)
#  index_attempts_on_interviewee_id  (interviewee_id)
#
# Foreign Keys
#
#  fk_rails_...  (interview_id => interviews.id)
#  fk_rails_...  (interviewee_id => interviewees.id)
#

require 'test_helper'

class AttemptTest < ActiveSupport::TestCase
  # test "the truth" do
  #   assert true
  # end
end
