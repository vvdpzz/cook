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
  
  #tabs based on tabs_on_rails
  class NavTabBuilder < TabsOnRails::Tabs::Builder
    def tab_for(tab, name, options, item_options = {})
      item_options[:class] = (current_tab?(tab) ? 'active' : 'inactive')
      @context.content_tag(:li) do
        @context.link_to(name, options,item_options)
      end
    end
  end
  
  class MenuTabBuilder < TabsOnRails::Tabs::Builder
    def tab_for(tab, name, options, item_options = {})
      item_options[:class] = (current_tab?(tab) ? 'clicked' : 'unclick')
      @context.content_tag(:li) do
        @context.link_to(name, options,item_options)
      end
    end
    
    def open_tabs(options = {})
      @context.tag("ul", options, open = true)
    end

    def close_tabs(options = {})
      "</ul>".html_safe
    end
  end

  def vote_stats(number)
    content_tag(:div, :class => 'votes') do
       [content_tag(:div, to_k(number), :class => 'mini-counts'), content_tag(:div, '投票', :class => 'stats_word')].join
    end
  end
  def answer_stats(number, selected)
    if selected != 0
      answer_status = "saccepted"
    elsif number > 0
      answer_status = "sanswered"
    else
      answer_status = "sunanswered"
    end
    content_tag(:div, :class => "status #{answer_status}") do
       [content_tag(:div, to_k(number), :class => 'mini-counts'), content_tag(:div, '答案', :class => 'stats_word')].join
    end
  end
  def view_stats(number)
    content_tag(:div, :class => 'views') do
       [content_tag(:div, to_k(number), :class => 'mini-counts'), content_tag(:div, '浏览', :class => 'stats_word')].join
    end
  end
  
end
