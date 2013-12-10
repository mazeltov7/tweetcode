class User < ActiveRecord::Base
  has_many :beginner_messages
  validates :username, presence: true
  validates :status, presence: true

  def self.create_with_omniauth(auth)
    create! do |user|
      user.provider = auth["provider"]
      user.uid = auth["uid"]
      user.username = auth["info"]["nickname"]
    end
  end
end
