require 'securerandom'

class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable

  has_many :profiles
  has_many :events
  has_many :devices

  validates :name, presence: true
  validates :email, presence: true
  validates :email, uniqueness: true

  mount_uploader :image, ImageUploader
  mount_base64_uploader :image, ImageUploader

  before_create :create_token

  def create_token
    if self.token.blank?
      self.token = SecureRandom.hex
    end
  end

  def send_goodbye_notification
    self.devices.each do |device|
      Message.create(:receiver_id => device.id, :title => "Arrivederci")
    end
  end

  def send_update_regions_notification
    self.devices.each do |device|
      Message.create(:receiver_id => device.id, :payload => '{"dicon_update_regions":true}', :content_available => 1)
    end
  end
end

# openssl base64 < file_path | tr -d '\n' | pbcopy
