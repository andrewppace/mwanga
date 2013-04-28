class Email < ActiveRecord::Base
  #mass assignment
  attr_accessible :address, :description
  
  #associations
  belongs_to :contact
  
  #validations
  validate :address, presence: true, email: true
  validate :description, presence: true, length: {in: 1..40}
end
