# frozen_string_literal: true

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

class Exam < ApplicationRecord
  has_and_belongs_to_many :categories
  has_many :exams_categories
  has_many :attempts
end
