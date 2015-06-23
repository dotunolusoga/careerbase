class Company < ActiveRecord::Base

  belongs_to :user
  has_many :notes

  validates :name, presence: true
  validates :url, presence: true
  validates :name, length: { minimum: 3 }
  validates :email, format: { with: /.+@.+\..+/, message: "must be an email address" }, uniqueness: true, allow_blank: true
  validates_presence_of :user

end
