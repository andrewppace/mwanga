class User < ActiveRecord::Base
  APP_SALT = "f94de6e9a304a0d0abdabdd7c908f31a01124a38"
  
  #mass assignment
  attr_accessible :email, :username, :password, :password_confirmation, :agreement, :first_name, :last_name
  attr_accessor :password, :agreement, :first_name, :last_name
  
  #associations
  has_many :profiles
  has_many :contacts
  has_many :connections, foreign_key: "invitor_id", class_name: "Relationship"
  has_many :recipients, foreign_key: "invitee_id", class_name: "Relationship"
  belongs_to :contact

  #validations
  validates :first_name, presence: true, length: {in: 1..40}, on: :create
  validates :last_name, presence: true, length: {in: 1..40}, on: :create
  validates :username, presence: true, length: {in: 3..40}, uniqueness: true, alphanumeric: true
  validates :email, presence: true, email: true, length: {in: 4..40}, nonwhitespace: true
  validates :password, presence: true, length: {in: 6..40}, nonwhitespace: true, confirmation: true, if: :password_needs_validation?
  validate :agreement_checked, on: :create

  #callbacks
  before_save :encrypt_password
  before_create :set_email_confirmation_salt
  before_update :check_email_for_change
  after_create :send_welcome_email
  after_create :create_contact
  
  #object state
  state_machine initial: :pending do
    event :activate do
      transition :pending => :active
    end
    event :deactivate do
      transition :active => :inactive
    end
    event :reactivate do
      transition :inactive => :active
    end
    after_transition :pending => :active, do: :send_activation_email
    after_transition :active => :inactive, do: :send_deactivation_email
    after_transition :inactive => :active, do: :send_reactivation_email
  end

  state_machine :email_state, initial: :unconfirmed do
    event :confirm do
      transition :unconfirmed => :confirmed
    end
    event :unconfirm do
      transition :confirmed => :unconfirmed
    end
    after_transition :confirmed => :unconfirmed, do: :send_unconfirm_email
  end

  def password_reset
    self.password = self.password_confirmation = generate_salt
    UserMailer.password_reset(self).deliver
  end

  def self.authenticate(username, password)
    u = self.find_all_by_username(username)
    if u.empty?
      false
    else
      u = u.first
      u.password_hash == ::Digest::SHA1.hexdigest(password + u.password_salt + APP_SALT) ? u : false
    end
  end

private
  def save_contact
    self.contact = Contact.new
    self.contact.user_id = self.user.id
    self.contact.save
  end
  
  def check_email_for_change
    if self.email_changed?
      self.email_confirmation_salt = generate_salt
      self.unconfirm
    end
  end
  def set_email_confirmation_salt
    self.email_confirmation_salt = generate_salt
  end
  def send_welcome_email
    UserMailer.welcome(self).deliver
  end  
  def send_unconfirm_email
    UserMailer.unconfirm(self).deliver
  end
  def send_activation_email
    UserMailer.activate(self).deliver
  end
  def send_deactivation_email
    UserMailer.deactivate(self).deliver
  end
  def send_reactivation_email
    UserMailer.reactivate(self).deliver
  end
  
  def password_needs_validation?
    needs_validation = true
    if new_record?
      needs_validation = true
    else
      if @password == ""
        needs_validation = false
      elsif @password == nil
        needs_validation = false
      else
        needs_validation = true
      end
    end
    needs_validation
  end
  
  def agreement_checked
    unless self.agreement == "yes"
      self.errors.add(:agreement, "must be accepted")
   end
  end
 
  def encrypt_password
    if self.password && self.password != ""
      self.password_salt = generate_salt
      self.password_hash = ::Digest::SHA1.hexdigest(self.password + self.password_salt + APP_SALT)
    end
  end
  def generate_salt(size=10)
    chars = ('a'..'z').to_a + ('A'..'Z').to_a + ['O', '1', '2', '3', '4', '5', '6', '7', '8', '9']
    (0...size).collect { chars[Kernel.rand(chars.length)] }.join
  end  
end
