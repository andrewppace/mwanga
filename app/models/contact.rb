class Contact < ActiveRecord::Base
  
  #mass assignment
  attr_accessible :first_name, :last_name
  
  #associations
  belongs_to :user
  has_many :emails
  has_many :addresses
  
  #validations
  validates :first_name, presence: true, length: {in: 1..40}
  validates :last_name, presence: true, length: {in: 1..40}
  
  def full_name
    "#{self.first_name} #{self.last_name}"
  end
end
