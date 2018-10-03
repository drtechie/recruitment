# == Schema Information
#
# Table name: exams
#
#  id         :bigint(8)        not null, primary key
#  config     :jsonb
#  name       :string
#  created_at :datetime         not null
#  updated_at :datetime         not null
#

require 'test_helper'

class ExamTest < ActiveSupport::TestCase
  # test "the truth" do
  #   assert true
  # end
end
