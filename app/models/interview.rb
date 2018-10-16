# frozen_string_literal: true

# == Schema Information
#
# Table name: interviews
#
#  id         :bigint(8)        not null, primary key
#  config     :jsonb
#  name       :string
#  created_at :datetime         not null
#  updated_at :datetime         not null
#

class Interview < ApplicationRecord
  has_and_belongs_to_many :categories
  has_many :interviews_categories
  has_many :attempts
  has_many :questions, through: :categories
end
