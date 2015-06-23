class Note < ActiveRecord::Base
  belongs_to :user
  belongs_to :company

  validates :content, presence: true
  validates :content, length: { maximum: 140 }
  validates_presence_of :user

end
