class Email < ActiveRecord::Base
  #mass assignment
  attr_accessible :address, :description
  
  #associations
  belongs_to :contact
  
  #validations
  validates :contact_id, presence: true
  validates :address, presence: true, email: true
  validates :description, length: {maximum: 40}, allow_nil: true
end
