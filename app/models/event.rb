class Event < ActiveRecord::Base
  attr_protected
  has_event_calendar

  def self.search(search)
    if search
      find(:all,:conditions => ['name LIKE ?',"%#{search}%"])
    else
      find(:all)
    end
  end
end
