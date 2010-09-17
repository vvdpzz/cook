class TagsController < ApplicationController
  
  set_tab :tags
  
  set_tab :popular,   :navigation, :only => %w(index popular)
  set_tab :nameabc,   :navigation, :only => %w(nameabc)
  
  def index
    @tags = pagination Tag.all.sort {|a,b| (b.count <=> a.count)}
  end

  def nameabc
    @tags = pagination Tag.nameabc
    render :index
  end

  def popular
    @tags = pagination Tag.all.sort {|a,b| (b.count <=> a.count)}
    render :index
  end

end
