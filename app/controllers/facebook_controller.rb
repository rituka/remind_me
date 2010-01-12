class FacebookController < ApplicationController
  protect_from_forgery :except => [:index, :uninstalled, :authorized] 
  # before_filter :only_for_facebook_users, :except => [:uninstalled]
  before_filter :find_facebook_account_during_uninstall, :only => [:uninstalled]
  before_filter :find_facebook_account, :except => [:uninstalled, :installed, :errors_with, :authorize_redirect, :authorized]

  def index
    redirect_to account_path(@account)
  end

  def authorized
  end

  def authorize_redirect
    installed
  end

  def installed
    @account = Account.find_or_create_by_facebook_params(facebook_session.user)
    raise ActiveRecord::RecordNotFound unless @account
    flash[:notice] = "The Facebook application is successfully installed."
    index
  end

  def privacy
  end

  def uninstalled
    find_facebook_account_during_uninstall
    if @account.uninstall
      render :nothing => true, :status => '200'
    else
      render :nothing => true, :status => '500'
    end
  end

  def help
  end
end
