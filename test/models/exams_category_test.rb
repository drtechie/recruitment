# == Schema Information
#
# Table name: exams_categories
#
#  id          :bigint(8)        not null, primary key
#  created_at  :datetime         not null
#  updated_at  :datetime         not null
#  category_id :bigint(8)
#  exam_id     :bigint(8)
#
# Indexes
#
#  index_exams_categories_on_category_id  (category_id)
#  index_exams_categories_on_exam_id      (exam_id)
#
# Foreign Keys
#
#  fk_rails_...  (category_id => categories.id)
#  fk_rails_...  (exam_id => exams.id)
#

require 'test_helper'

class ExamCategoryTest < ActiveSupport::TestCase
  # test "the truth" do
  #   assert true
  # end
end
