class User < ApplicationRecord
  has_secure_password
  has_many :sessions, dependent: :destroy

  normalizes :email_address, with: ->(e) { e.strip.downcase }

  def self.find_or_create_from_google_auth(auth)
    where(email_address: auth.info.email).first_or_initialize.tap do |user|
      user.email_address = auth.info.email
      user.password = SecureRandom.hex(20) if user.new_record?
      # user.name = auth.info.name if user.respond_to?(:name)
      # user.google_uid = auth.uid
      # user.google_token = auth.credentials.token
      user.save!
    end
  end
end
