module ApplicationHelper
	def title(text)
	    content_for :title do
	      " - #{text}"
	    end
  	end

  	def current_url
    	url_for(params.merge(:only_path => false))
 	end
end
