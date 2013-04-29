class Contact < ActiveRecord::Base
  
  #mass assignment
  attr_accessible :first_name, :last_name
  
  #associations
  belongs_to :user
  has_many :emails
  
  #validations
  validates :first_name, presence: true, length: {in: 1..40}
  validates :last_name, presence: true, length: {in: 1..40}
end
