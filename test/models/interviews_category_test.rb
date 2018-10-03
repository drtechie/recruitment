# == Schema Information
#
# Table name: interviews_categories
#
#  id           :bigint(8)        not null, primary key
#  created_at   :datetime         not null
#  updated_at   :datetime         not null
#  category_id  :bigint(8)
#  interview_id :bigint(8)
#
# Indexes
#
#  index_interviews_categories_on_category_id   (category_id)
#  index_interviews_categories_on_interview_id  (interview_id)
#
# Foreign Keys
#
#  fk_rails_...  (category_id => categories.id)
#  fk_rails_...  (interview_id => interviews.id)
#

require 'test_helper'

class ExamCategoryTest < ActiveSupport::TestCase
  # test "the truth" do
  #   assert true
  # end
end
