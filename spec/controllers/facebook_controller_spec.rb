require File.dirname(__FILE__) + '/../spec_helper'

describe FacebookController, "under a rest request from inside Facebook with the application installed" do  
  describe "handling GET /facebook.fbml" do
    it_should_behave_like "An installed Facebook Application"
    it_should_behave_like "A valid Facebook session"
    it_should_behave_like "An Account created through Facebook"

    def do_get
      get :index, :format => 'fbml'
    end

    it "should redirect to errors page if facebook account cannot be found" do
      Account.stub!(:find_by_facebook_uid).and_raise(ActiveRecord::RecordNotFound)
      do_get
      flash[:error].should == "Could Not Find Account"
    end
  end

  describe "handling POST /facebook/installed.fbml" do
    it_should_behave_like "An installed Facebook Application"
    it_should_behave_like "A valid Facebook session"

    def do_post
      post :installed, :format => 'fbml'
    end

    it "should redirect to the index action" do
      do_post
      response.flash[:notice].should == "The Facebook application is successfully installed."
    end
  end

  describe "handling POST /facebook/uninstalled.fbml" do
    fixtures :accounts
    it_should_behave_like "A valid Facebook session"

    before(:each) do
      @account = mock_account
    end

    def do_post
      post :uninstalled, :format => 'fbml'
    end

    it "should deactivate a facebook account but not destroy the record" do
      @account = accounts(:new_facebook_user)
      Account.stub!(:find_by_facebook_uid).and_return(@account)
      do_post
      response.should be_success
      @account.active.should == false
      assigns[:account].id.should == @account.id
      assigns[:account].active.should == false
    end

    it "should render an error if the uninstall fails" do
      @account = accounts(:new_facebook_user)
      @account.stub!(:uninstall).and_return(false)
      Account.stub!(:find_by_facebook_uid).and_return(@account)
      do_post
      response.headers['Status'].should == '500'
      response.should_not be_success
    end

    it "should render an error if the account cannot be found during uninstall" do
      Account.stub!(:find_by_facebook_uid).and_raise(ActiveRecord::RecordNotFound)
      do_post
      response.headers['Status'].should == '500'
      response.should_not be_success
    end
  end
end

describe FacebookController, "when accessing informational pages" do
  it_should_behave_like "An installed Facebook Application"
  it_should_behave_like "A valid Facebook session"
  it_should_behave_like "An Account created through Facebook"  

  it "should display the about page" do
    get :about, { :format => :fbml }
    response.should be_success
    response.body =~ /facebook\/about/
  end

  it "should display the help page" do
    get :help, { :format => :fbml }
    response.should be_success
    response.body =~ /facebook\/help/
  end

  it "should display the privacy page" do
    get :privacy, { :format => :fbml }
    response.should be_success
    response.body =~ /facebook\/privacy/
  end  
end

describe FacebookController, "under a rest request from outside of Facebook" do
  describe "handling GET /facebook" do
    it "should redirect you to the home url" do
      get :index
      response.flash[:error].should == "This page must be viewed within Facebook."
      response.should redirect_to(root_url)
    end
  end
end  
