# == Schema Information
#
# Table name: events
#
#  id         :bigint(8)        not null, primary key
#  name       :string
#  params     :json
#  created_at :datetime         not null
#  updated_at :datetime         not null
#  attempt_id :bigint(8)
#
# Indexes
#
#  index_events_on_attempt_id  (attempt_id)
#
# Foreign Keys
#
#  fk_rails_...  (attempt_id => attempts.id)
#
class Event < ApplicationRecord
  belongs_to :attempt
end
