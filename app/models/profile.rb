class Profile < ActiveRecord::Base
  #mass assignment
  attr_accessible :description
  
  #associations
  belongs_to :user
  belongs_to :contact

  #validations
  validates :description, presence: true, length: {in: 1..40}
  validates :user_id, presence: true
  validate :description_unique_for_user

  #callbacks
  before_save :save_contact
  after_destroy :destroy_contact

private
  def description_unique_for_user
    unless self.user_id.nil?
      p = User.find_by_id(self.user_id).profiles
      p.delete_if{|profile| profile.id == self.id}
      if p.collect(&:description).include?(self.description)
        errors.add(:description, "must be unique")
      end
    end
  end
  
  def save_contact
    self.contact.user_id = self.user.id
    self.contact.save
  end
  
  def destroy_contact
    self.contact.destroy
  end
end
