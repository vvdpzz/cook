module ApplicationHelper
  def coderay(text)
    text.gsub(/(\[code\:([a-z].+?)\](.+?)\[\/code\])/m) do
      CodeRay.scan($3, $2).div(:css => :class)
    end
  end
  
  def safe_html(text)
    sanitize text, :tags => %w(div span h1 h2 h3 h4 h5 h6 p a b strong pre img br table th tr td ol ul li),
                   :attributes => %w(class href src width height)
  end
  
  def to_k(number)
    # number_to_human algorithm based on log(a,b), which b must > 0 
    if number > 0
      return number_to_human number, { :format => "%n%u", :units => {:unit => "", :thousand => "k"} }
    else
      return number
    end
  end
end
