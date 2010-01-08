module ApplicationHelper
  
  # Converts the normal Rails flash methods into the message types expected by Facebook.
  def render_facebook_flash(custom_flash = nil)
    message = custom_flash || flash
    flash_types = [:notice, :warning]
    message.keys.each do |x|
     case x 
       when :notice
         message[:success] = message[:notice]
       when :warning
         message[:explanation] = message[:warning]
     end
    end
    flash_types = [:error, :explanation, :success]
    flash_type = flash_types.detect { |a| message.keys.include?(a) }
    "<fb:%s><fb:message>%s</fb:message></fb:%s>" % [flash_type.to_s, message[flash_type],flash_type.to_s] if flash_type 
  end
end