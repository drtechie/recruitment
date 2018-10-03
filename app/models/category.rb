# frozen_string_literal: true

# == Schema Information
#
# Table name: categories
#
#  id         :bigint(8)        not null, primary key
#  name       :string
#  created_at :datetime         not null
#  updated_at :datetime         not null
#  parent_id  :bigint(8)
#
# Indexes
#
#  index_categories_on_name  (name)
#

class Category < ApplicationRecord
  extend ActsAsTree::TreeView
  acts_as_tree order: "name"
  validates_presence_of :name
  has_many :categories_questions
  has_many :interviews_categories
  has_many :attempts_categories, class_name: "AttemptsCategories"
  has_and_belongs_to_many :questions
  has_and_belongs_to_many :interviews
  has_and_belongs_to_many :attempts
end
