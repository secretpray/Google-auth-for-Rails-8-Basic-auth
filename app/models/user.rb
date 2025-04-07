require "open-uri"

class User < ApplicationRecord
  has_secure_password
  has_many :sessions, dependent: :destroy
  has_one_attached :avatar

  normalizes :email_address, with: ->(e) { e.strip.downcase }

  def self.find_or_create_from_auth(auth)
    where(email_address: auth.info.email).first_or_initialize.tap do |user|
      user.email_address = auth.info.email
      user.password = SecureRandom.hex(20) if user.new_record?
      user.first_name = auth.info.first_name || auth.info.name if user.respond_to?(:first_name)
      user.last_name = auth.info.last_name if user.respond_to?(:last_name)
      user.provider = auth.provider
      user.provider_uid = auth.uid
      user.provider_token = auth.credentials.token
      user.save!
      user.attach_avatar_if_available(auth)
      user
    end
  end

  def attach_avatar_if_available(auth)
    if auth.info.image.present?
      attach_auth_avatar(auth.info.image)
    else
      attach_default_avatar
    end
  end

  private

  def attach_auth_avatar(image)
    image_uri = URI.parse(image)
    image_io = image_uri.open
    content_type = image_io.content_type
    extension = Rack::Mime::MIME_TYPES.invert[content_type] || ".jpg"
    self.avatar.attach(io: image_io, filename: "avatar-#{self.id}#{extension}")
  rescue OpenURI::HTTPError, SocketError => e
    Rails.logger.error "Failed to attach avatar for user #{self.id}: #{e.message}"
  end

  def attach_default_avatar
    filename = "default-avatar.jpg"
    path = Rails.root.join("app", "assets", "images", filename)
    File.open(path, "rb") do |file|
      self.avatar.attach(
        io: file,
        filename: filename,
        content_type: "image/jpeg"
      )
    end
  end
end
