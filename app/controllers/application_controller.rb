class ApplicationController < ActionController::Base
  protect_from_forgery
  
  def pagination(object,number=params[:per_page])
    object.paginate :page => params[:page], :per_page => number
  end
  
  def set_voted(object)
    object.voted = object.plusminus
    object.save
  end
  
  def save_event(s,e,t)
    Event.create(:s => s.id, :e => e, :t => t.id, :c => t.class.name)
  end
end
