class Note < ActiveRecord::Base
  belongs_to :user
  belongs_to :company

  validates :content, presence: true
  validates_presence_of :user

end
