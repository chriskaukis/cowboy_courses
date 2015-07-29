module ApplicationHelper
  def carrier_options_for_select(selected = nil)
    options_for_select(carrier_choices_for_select, selected)
  end
  
  def carrier_choices_for_select
    SMS_CONFIG['carriers'].collect { |k, v| [v['name'], k] }.sort { |a, b| a[0] <=> b[0] }
  end
  
  def current_url
    url_for(params.merge(:only_path => false))
  end
  
  def title(text)
    content_for :title do
      " - #{text}"
    end
  end
end
