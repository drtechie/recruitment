# == Schema Information
#
# Table name: essays
#
#  id                :bigint(8)        not null, primary key
#  answer_max_length :integer
#  answer_min_length :integer
#  created_at        :datetime         not null
#  updated_at        :datetime         not null
#

require 'test_helper'

class EssayTest < ActiveSupport::TestCase
  # test "the truth" do
  #   assert true
  # end
end
