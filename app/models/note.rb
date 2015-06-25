class Note < ActiveRecord::Base
  belongs_to :user
  belongs_to :company

  default_scope { order('created_at DESC') }

  validates :content, presence: true
  validates_presence_of :user

end
