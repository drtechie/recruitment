# frozen_string_literal: true

# == Schema Information
#
# Table name: categories_questions
#
#  id          :bigint(8)        not null, primary key
#  created_at  :datetime         not null
#  updated_at  :datetime         not null
#  category_id :bigint(8)
#  question_id :bigint(8)
#
# Indexes
#
#  index_categories_questions_on_category_id  (category_id)
#  index_categories_questions_on_question_id  (question_id)
#
# Foreign Keys
#
#  fk_rails_...  (category_id => categories.id)
#  fk_rails_...  (question_id => questions.id)
#

class CategoriesQuestion < ApplicationRecord
  belongs_to :category
  belongs_to :question
end
