class Contact < ActiveRecord::Base
  
  #mass assignment
  attr_accessible :first_name, :last_name
  attr_accessor :first_name, :last_name
  
  #associations
  belongs_to :user
  has_many :first_names
  has_many :last_names
  has_many :emails
  has_many :addresses
  
  #validations
  validates :first_name, presence: true, length: {in: 1..40}, if: :first_names_empty?
  validates :last_name, presence: true, length: {in: 1..40}, if: :last_names_empty?
  
  #callbacks
  after_save :create_first_and_last_names
  
private
  def create_first_and_last_names
    if self.first_names.empty?
      self.first_names << FirstName.new(name: self.first_name)
    end
    if self.last_names.empty?
      self.last_names << LastName.new(name: self.last_name)
    end
  end
  def first_names_empty?
    self.first_names.empty?
  end
  def last_names_empty?
    self.last_names.empty?
  end
end
