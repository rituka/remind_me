# This module contains a collection of helper methods that make detecting and 
# responding to Facebook methods easier.
module FacebookerFilters
  def self.included(base)
    base.class_eval do
      # The is a conditional before_filter that will only fire for requests using the fbml format.
      before_filter(:except => :uninstalled) do |controller|
        if true
          # This session property will be set if the user has called the allow_login_from_facebook is called before this 
          # filter; for example, prepend_before_filter :allow_login_from_facebook, :only => [:show]
          if controller.session[:authenticate_through_facebook].nil? || controller.session[:authenticate_through_facebook] == false
            controller.send(:ensure_application_is_installed_by_facebook_user)
          end
        end
      end
    end
  end
  
  def only_login_from_facebook_required
    session[:authenticate_through_facebook] = true
  end
  
  # For requests that use .fbml
  def find_facebook_account
    @facebook_session = facebook_session
    @account = Account.find_by_facebook_uid(@facebook_session.user.uid)
    
    raise ActiveRecord::RecordNotFound unless @account
    # Assign the current_account so that the existing before_filters that check for authentication can find this user.
    # self.current_account = @account
    @account
  rescue ActiveRecord::RecordNotFound
    flash[:error] = "Could Not Find Account"
    redirect_to(installed_path(:format => 'fbml')) and return false
  end

  # Deny access to any request that does not use the fbml format.
  def only_for_facebook_users
    unless params['format'].to_s == "fbml"
      flash[:error] = "This page must be viewed within Facebook."
      redirect_to root_url and return false 
    end
  end
  
  def find_facebook_account_during_uninstall
    @account = Account.find_by_facebook_uid(params["fb_sig_user"])
    raise ActiveRecord::RecordNotFound unless @account
    @account
  rescue ActiveRecord::RecordNotFound
    render :nothing => true, :status => '500' and return false
  end
end
