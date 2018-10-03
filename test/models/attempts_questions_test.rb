# == Schema Information
#
# Table name: attempts_questions
#
#  id          :bigint(8)        not null, primary key
#  created_at  :datetime         not null
#  updated_at  :datetime         not null
#  attempt_id  :bigint(8)
#  question_id :bigint(8)
#
# Indexes
#
#  index_attempts_questions_on_attempt_id   (attempt_id)
#  index_attempts_questions_on_question_id  (question_id)
#
# Foreign Keys
#
#  fk_rails_...  (attempt_id => attempts.id)
#  fk_rails_...  (question_id => questions.id)
#

require 'test_helper'

class AttemptQuestionTest < ActiveSupport::TestCase
  # test "the truth" do
  #   assert true
  # end
end
