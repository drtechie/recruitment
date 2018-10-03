# frozen_string_literal: true

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

class Question < ApplicationRecord
  belongs_to :questionable, polymorphic: true
  has_many :categories_questions
  has_many :attempts_questions, class_name: "AttemptsQuestions"
  has_and_belongs_to_many :categories
  has_and_belongs_to_many :attempts
end
