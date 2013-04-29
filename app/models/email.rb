class Email < ActiveRecord::Base
  #mass assignment
  attr_accessible :address, :description
  
  #associations
  belongs_to :contact
  
  #validations
  validates :address, presence: true, email: true
  validates :description, length: {in: 1..40}, allow_nil: true
end
