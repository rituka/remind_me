class AccountsController < ApplicationController
  # before_filter :only_for_facebook_users
  before_filter :find_facebook_account

  # Used to view your own account
  # GET /accounts
  # GET /accounts.fbml
  def index
    respond_to do |format|
      format.fbml # index.fbml.erb
    end
  end

  # Used to view another user's account
  # GET /show/1
  # GET /show/1.fbml
  def show
    respond_to do |format|
      format.fbml {} # show.fbml
    end
  end
end
