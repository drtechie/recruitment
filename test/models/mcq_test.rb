# == Schema Information
#
# Table name: mcqs
#
#  id              :bigint(8)        not null, primary key
#  correct_options :integer          default([]), is an Array
#  options         :text             default([]), is an Array
#  created_at      :datetime         not null
#  updated_at      :datetime         not null
#

require 'test_helper'

class McqTest < ActiveSupport::TestCase
  # test "the truth" do
  #   assert true
  # end
end
