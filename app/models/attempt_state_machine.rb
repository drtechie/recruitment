# frozen_string_literal: true

class AttemptStateMachine
  include Statesman::Machine

  state :not_started, initial: true
  state :in_progress
  state :submitted
  state :reviewed

  transition from: :not_started,    to: %i[in_progress]
  transition from: :in_progress,    to: %i[submitted]
  transition from: :submitted, to: %i[reviewed]
end
