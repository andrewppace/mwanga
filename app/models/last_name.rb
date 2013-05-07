class LastName < ActiveRecord::Base
  attr_accessible :name
  belongs_to :contact
end
