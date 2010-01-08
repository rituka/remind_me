ENV["RAILS_ENV"] = "test"
require File.expand_path(File.dirname(__FILE__) + "/../config/environment")
require 'spec'
require 'spec/rails'
require 'ruby-debug'

Spec::Runner.configure do |config|
  # If you're not using ActiveRecord you should remove these
  # lines, delete config/database.yml and disable :active_record
  # in your config/boot.rb
  config.use_transactional_fixtures = true
  config.use_instantiated_fixtures  = false
  config.fixture_path = RAILS_ROOT + '/spec/fixtures/'

  module Spec
    module Mocks
      module Methods
        def stub_association!(association_name, methods_to_be_stubbed = {})
          mock_association = Spec::Mocks::Mock.new(association_name.to_s)
          methods_to_be_stubbed.each do |method, return_value|
            mock_association.stub!(method).and_return(return_value)
          end
          self.stub!(association_name).and_return(mock_association)
        end
      end
    end
  end
  
  def mock_account(opts = {})
    unless @account
      @account = mock_model(Account, { :id => 1,
                                       :facebook_uid => "123456789",
                                       :active => true,
                                       :update_attribute => true,
                                       :update_attributes => true }.merge(opts))
    end
    @account
  end
  
  def mock_facebooker_session(opts = {})
    mock_model(Facebooker::User, { :id => 1,
                                   :first_name => 'Quentin',
                                   :last_name => 'Jones',
                                   :name => 'Quentin Jones',
                                   :uid =>'987654321',
                                   :profile_fbml= => true,
                                   :is_app_user => true }.merge(opts))
  end
  
  describe "An installed Facebook Application", :shared => true do
    before(:each) do
      @controller.should_receive(:ensure_application_is_installed_by_facebook_user).at_least(:once).and_return(true)
    end
  end
  
  describe "Logged into Facebook Application", :shared => true do
    before(:each) do
      @controller.should_receive(:ensure_authenticated_to_facebook).at_least(:once).and_return(true)
    end
  end
  
  describe "An Installed Application With Extended Params", :shared => true do
    before(:each) do
      @controller.should_receive(:ensure_has_status_update).at_least(:once).and_return(true)
    end
  end
  
  describe "An Account", :shared => true do
    before(:each) do
      Account.stub!(:find).and_return(mock_account)
    end
  end
    
  describe "An Account created through Facebook", :shared => true do
    before(:each) do
      Account.stub!(:find_by_facebook_uid).and_return(mock_account)
    end
  end
  
  describe "A valid Facebook session", :shared => true do
    before(:each) do
      @session = mock('fb_session',{ :user => mock_facebooker_session })
      @controller.session = Facebooker::Session.create(ENV['FACEBOOK_API_KEY'], ENV['FACEBOOK_SECRET_KEY'])
      @controller.stub!(:facebook_session).and_return(@session)
    end
  end
end
