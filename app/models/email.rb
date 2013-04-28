class Email < ActiveRecord::Base
  #mass assignment
  attr_accessible :address, :description
  
  #associations
  belongs_to :contact
  has_and_belongs_to_many :profiles, join_table: "profiles_emails"
  
  #validations
  validate :address, presence: true, email: true
  validate :description, presence: true, length: {in: 1..40}
end
