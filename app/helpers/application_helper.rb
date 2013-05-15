module ApplicationHelper
	DAYS = [:sunday, :monday, :tuesday, :wednesday, :thursday, :friday, :saturday]
	WEEKDAYS = [:monday, :tuesday, :wednesday, :thursday, :friday]
	
	DISMISSALS = [
		{:name=>"Pick Up",:id=>0},
		{:name=>"JAZ",:id=>1},
		{:name=>"BEARS",:id=>2},
		{:name=>"Walk",:id=>3}]
  
  def maybe_class(class_name, condition)
    condition ? {:class => class_name} : {}
  end
  
  def active_if(condition)
    maybe_class("active", condition)
  end

  def dollar_amount(val, options = {})
    if val
       dollar_amount = "$" + number_with_precision(val, :precision => 2)
       if options[:starred]
       	 dollar_amount += "<sup>*</sup>"
       end
    end
    return dollar_amount.html_safe
  end
end
