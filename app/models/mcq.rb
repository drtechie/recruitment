# frozen_string_literal: true

# == Schema Information
#
# Table name: mcqs
#
#  id         :bigint(8)        not null, primary key
#  options    :jsonb
#  created_at :datetime         not null
#  updated_at :datetime         not null
#

class Mcq < ApplicationRecord
  has_one :question, as: :questionable, dependent: :destroy
  accepts_nested_attributes_for :question, reject_if: ->(attributes) { attributes["title"].blank? }
  has_many :categories, through: :question
end
