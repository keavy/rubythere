class Event < ActiveRecord::Base
  belongs_to :location
  validates_presence_of :name, :message => '^Please add a name'
end
