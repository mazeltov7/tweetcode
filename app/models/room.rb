class Room < ActiveRecord::Base
  has_many :messages
  belongs_to :user

  validates :name,
    presence: true,
    length: {minimum: 1, maximum: 20}
  validates :description,
    length: {maximum: 50}
    
end
