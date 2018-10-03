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
#  exam_id        :bigint(8)
#  interviewee_id :bigint(8)
#
# Indexes
#
#  index_attempts_on_exam_id         (exam_id)
#  index_attempts_on_interviewee_id  (interviewee_id)
#
# Foreign Keys
#
#  fk_rails_...  (exam_id => exams.id)
#  fk_rails_...  (interviewee_id => interviewees.id)
#

require 'test_helper'

class AttemptTest < ActiveSupport::TestCase
  # test "the truth" do
  #   assert true
  # end
end
