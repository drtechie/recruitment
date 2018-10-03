# frozen_string_literal: true
# == Schema Information
#
# Table name: attempts
#
#  id             :bigint(8)        not null, primary key
#  ended_at       :datetime
#  response       :jsonb
#  started_at     :datetime
#  created_at     :datetime         not null
#  updated_at     :datetime         not null
#  interview_id   :bigint(8)
#  interviewee_id :bigint(8)
#
# Indexes
#
#  index_attempts_on_interview_id    (interview_id)
#  index_attempts_on_interviewee_id  (interviewee_id)
#
# Foreign Keys
#
#  fk_rails_...  (interview_id => interviews.id)
#  fk_rails_...  (interviewee_id => interviewees.id)
#

class Attempt < ApplicationRecord
  has_many :attempts_questions, class_name: "AttemptsQuestions"
  has_many :attempts_categories, class_name: "AttemptsCategories"
  has_and_belongs_to_many :questions
  has_and_belongs_to_many :categories
  belongs_to :interviewee
  belongs_to :interview
end
