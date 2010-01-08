# Filters added to this controller apply to all controllers in the application.
# Likewise, all the methods added will be available for all controllers.

class ApplicationController < ActionController::Base
  include FacebookerFilters
  helper :all # include all helpers, all the time

  # See ActionController::RequestForgeryProtection for details
  # Uncomment the :secret if you're not using the cookie session store
  protect_from_forgery  :secret => 'CHANGE ME TO SOMETHING SECURE'

  # For use with will_paginate calls
  # For example: Account.paginate(:all, pagination_params.merge(:conditions => { :active => true }))
  
  def pagination_params(opts = {})
    { :page => params[:page] || 1, :per_page => params[:per_page] || 50 }.merge(opts)
  end

  # Redefine the needs permission method to include our redirect back to our app.
  # This is to ensure we don't end up on a dead-end page on Facebook.
  def application_needs_permission(perm)
    redirect_to(facebook_session.permission_url(perm, :next => "http://apps.facebook.com/#{ENV['FACEBOOKER_RELATIVE_URL_ROOT']}"+request.request_uri))
  end
end
