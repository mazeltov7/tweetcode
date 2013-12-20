# coding:utf-8


class User < ActiveRecord::Base
  has_many :beginner_messages
  has_many :rooms
  validates :username,
    presence: true,
    length: {minimum: 1, maximum: 20}
  validates :status,
    presence: true,
    length: {minimum: 1, maximum: 20}

  def self.create_with_omniauth(auth)
    create! do |user|
      user.provider = auth["provider"]
      user.uid = auth["uid"]
      user.username = auth["info"]["nickname"]
      user.status = 'ここにやってることを入れて下さい'
    end
  end
end
