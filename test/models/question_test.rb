# == Schema Information
#
# Table name: questions
#
#  id                :bigint(8)        not null, primary key
#  questionable_type :string
#  title             :string
#  created_at        :datetime         not null
#  updated_at        :datetime         not null
#  questionable_id   :bigint(8)
#
# Indexes
#
#  index_questions_on_questionable_type_and_questionable_id  (questionable_type,questionable_id)
#

require 'test_helper'

class QuestionTest < ActiveSupport::TestCase
  # test "the truth" do
  #   assert true
  # end
end
