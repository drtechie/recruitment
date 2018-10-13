# frozen_string_literal: true

# == Schema Information
#
# Table name: users
#
#  id                     :bigint(8)        not null, primary key
#  admin                  :boolean
#  confirmation_sent_at   :datetime
#  confirmation_token     :string
#  confirmed_at           :datetime
#  current_sign_in_at     :datetime
#  current_sign_in_ip     :inet
#  email                  :string           default(""), not null
#  encrypted_password     :string           default(""), not null
#  failed_attempts        :integer          default(0), not null
#  first_name             :string
#  last_name              :string
#  last_sign_in_at        :datetime
#  last_sign_in_ip        :inet
#  locked_at              :datetime
#  middle_name            :string
#  remember_created_at    :datetime
#  reset_password_sent_at :datetime
#  reset_password_token   :string
#  sign_in_count          :integer          default(0), not null
#  title                  :string
#  unconfirmed_email      :string
#  unlock_token           :string
#  created_at             :datetime         not null
#  updated_at             :datetime         not null
#
# Indexes
#
#  index_users_on_confirmation_token    (confirmation_token) UNIQUE
#  index_users_on_email                 (email) UNIQUE
#  index_users_on_reset_password_token  (reset_password_token) UNIQUE
#  index_users_on_unlock_token          (unlock_token) UNIQUE
#

class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable,
         :recoverable, :rememberable, :validatable,
         :trackable, :confirmable, :lockable

  validates :email, format: { with: URI::MailTo::EMAIL_REGEXP, message: "Only valid emails allowed." }

  has_one :interviewee

  def self.create_token(client_id, user_id, ttl = DEFAULT_TOKEN_TTL)
    expiry = Time.now.advance seconds: ttl
    raw_token = Devise.friendly_token(30)
    encrypted_token = Digest::SHA1.hexdigest raw_token
    tok = AuthToken.create! client_id: client_id, expires: expiry, user_id: user_id, token: encrypted_token
    { token: raw_token, expires: tok.expires.to_i }
  end

  def full_name
    @full_name ||= "#{get_string title}#{get_string first_name}#{get_string middle_name}#{get_string last_name}".chop
  end

  def password_required?
    new_record? ? false : super
  end

  private

  def get_string(str)
    str.nil? ? "" : "#{str} "
  end
end
