class Event < ApplicationRecord
	has_many :attendees
	has_one :location
	has_many :event_groupships
	has_many :groups, :through => :event_groupships
	belongs_to :category
	validates_presence_of :name
	delegate :name, :to => :category, :prefix => true, :allow_nil => true
end
