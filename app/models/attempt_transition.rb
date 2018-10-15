# frozen_string_literal: true

# == Schema Information
#
# Table name: attempt_transitions
#
#  id          :bigint(8)        not null, primary key
#  metadata    :json
#  most_recent :boolean          not null
#  sort_key    :integer          not null
#  to_state    :string           not null
#  created_at  :datetime         not null
#  updated_at  :datetime         not null
#  attempt_id  :integer          not null
#
# Indexes
#
#  index_attempt_transitions_parent_most_recent  (attempt_id,most_recent) UNIQUE WHERE most_recent
#  index_attempt_transitions_parent_sort         (attempt_id,sort_key) UNIQUE
#
# Foreign Keys
#
#  fk_rails_...  (attempt_id => attempts.id)
#

class AttemptTransition < ActiveRecord::Base
  validates :to_state, inclusion: { in: AttemptStateMachine.states }
  belongs_to :attempt, inverse_of: :transitions
  after_destroy :update_most_recent, if: :most_recent?

  private

  def update_most_recent
    last_transition = attempt.attempt_transitions.order(:sort_key).last
    return unless last_transition.present?

    last_transition.update_column(:most_recent, true)
  end
end
