class ApplicationController < ActionController::Base
  protect_from_forgery
  
  def save_event(s,e,t)
    Event.create(:s => s.id, :e => e, :t => t.id, :c => t.class.name)
  end
end
