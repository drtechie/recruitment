# frozen_string_literal: true

# == Schema Information
#
# Table name: attempts_categories
#
#  id          :bigint(8)        not null, primary key
#  created_at  :datetime         not null
#  updated_at  :datetime         not null
#  attempt_id  :bigint(8)
#  category_id :bigint(8)
#
# Indexes
#
#  index_attempts_categories_on_attempt_id   (attempt_id)
#  index_attempts_categories_on_category_id  (category_id)
#
# Foreign Keys
#
#  fk_rails_...  (attempt_id => attempts.id)
#  fk_rails_...  (category_id => categories.id)
#

class AttemptsCategories < ApplicationRecord
  belongs_to :attempt
  belongs_to :category
end
