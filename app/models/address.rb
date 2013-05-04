class Address < ActiveRecord::Base
  #mass assignment
  attr_accessible :pobox, :extended, :street, :city, :state, :zipcode, :country, :label
  
  #associations
  belongs_to :contact
    
  #validations
  validates :pobox, length: {in: 1..255}, allow_blank: true
  validates :extended, length: {in: 1..255}, allow_blank: true
  validates :street, length: {in: 1..255}, allow_blank: true
  validates :city, length: {in: 1..255}, allow_blank: true
  validates :state, length: {in: 1..255}, allow_blank: true
  validates :zipcode, length: {in: 1..255}, allow_blank: true
  validates :country, length: {in: 1..255}, allow_blank: true
  validates :label, length: {in: 1..255}, allow_blank: true
  validate :something_must_be_present
    
private
  def something_must_be_present
    self.errors[:base] << ("must specify something") if self.pobox.blank? && self.extended.blank? && self.street.blank? && self.city.blank? && self.state.blank? && self.zipcode.blank? && self.country.blank?
  end
end
