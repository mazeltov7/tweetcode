class Message < ActiveRecord::Base
  belongs_to :room
  belongs_to :user

    validates :body,
      presence: true,
      length: {maximum: 140}

end
