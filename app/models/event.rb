class Event < ActiveRecord::Base
  validates_presence_of :name, :message => '^Please add a name'
end
