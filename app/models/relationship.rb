class Relationship < ActiveRecord::Base
  #associations
  belongs_to :invitor, class_name: "User"
  belongs_to :invitee, class_name: "User"
  belongs_to :profile
  
  #validations
  validates :invitor_id, presence: true
  validates :invitee_id, presence: true
  validates :profile_id, presence: true, if: :profile_present_if_state_anything_but_pending
  validate :invitor_id_invitee_id_unique

  #state
  state_machine :initial => :pending do
    event :activate do
      transition :pending => :active
    end
    
    event :invitor_inactivate do
      transition :active => :invitor_inactive
      transition :invitee_inactive => :inactive
    end
    
    event :invitee_inactivate do
      transition :active => :invitee_inactive
      transition :invitor_inactive => :inactive
    end
    
    event :invitee_reactivate do
      transition :invitee_inactive => :active
      transition :inactive => :invitor_inactive
    end
    
    event :invitor_reactivate do
      transition :invitor_inactive => :active
      transition :inactive => :invitee_inactive
    end
  end

private

  def profile_present_if_state_anything_but_pending
    self.pending?
  end
  
  def invitor_id_invitee_id_unique
    Relationship.find_all_by_invitor_id(self.invitor_id).each do |relationship|
      if relationship.invitee_id == self.invitee_id
        self.errors.add(:base) << "this relationship already exists" unless relationship.id == self.id
      end
    end
  end
end
