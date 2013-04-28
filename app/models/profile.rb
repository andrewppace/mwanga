class Profile < ActiveRecord::Base
  #mass assignment
  attr_accessible :description
  
  #associations
  belongs_to :user

  #validations
  validates :description, presence: true, length: {in: 1..40}
  validates :user_id, presence: true
  validate :description_unique_for_user

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
end
