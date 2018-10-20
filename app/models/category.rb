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
  extend ActsAsTree::TreeWalker
  acts_as_tree order: "name"
  validates_presence_of :name
  has_many :categories_questions
  has_many :interviews_categories
  has_many :attempts_categories, class_name: "AttemptsCategories"
  has_and_belongs_to_many :questions
  has_and_belongs_to_many :interviews
  has_and_belongs_to_many :attempts

  def self.parents_and_children(categories)
    all_categories = []
    categories.includes(:children).each do |category|
      all_categories << category
      category.children.map do |child|
        all_categories << child
      end
    end
    all_categories.uniq
  end

  def self.get_tree(categories)
    category_tree = []
    categories.includes(:children).each do |category|
      category_tree << category_json(category).merge!("children": category.children.map do |c|
        category_json(c)
      end).as_json
    end
    category_tree
  end

  def self.category_json(category)
    {
      id: category.id,
      value: category.id,
      title: category.name,
      key: category.id
    }
  end

  private_class_method :category_json
end
