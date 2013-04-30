class Address
  #mass assignment
  attr_accessible :pobox, :extended, :street, :city, :state, :zipcode, :country, :label
    
  #validations
  validates :pobox, length: {in: 1..255}, allow_nil: true
  validates :extended, length: {in: 1..255}, allow_nil: true
  validates :street, length: {in: 1..255}, allow_nil: true
  validates :city, length: {in: 1..255}, allow_nil: true
  validates :state, length: {in: 1..255}, allow_nil: true
  validates :zipcode, length: {in: 1..255}, allow_nil: true
  validates :country, length: {in: 1..255}, allow_nil: true
  validates :label, length: {in: 1..255}, allow_nil: true
  validate :something_must_be_present
    
private
  def something_must_be_present
    self.errors[:base] << ("must specify something") if self.pobox.nil? && self.extended.nil? && self.street.nil? && self.city.nil? && self.state.nil? && self.zipcode.nil? && self.country.nil?
  end
end
