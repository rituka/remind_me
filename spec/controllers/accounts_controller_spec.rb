require File.expand_path(File.dirname(__FILE__) + '/../spec_helper')

describe AccountsController do  
  describe "responding to GET index" do
    it_should_behave_like "An installed Facebook Application"
    it_should_behave_like "A valid Facebook session"
    it_should_behave_like "An Account created through Facebook"

    it "should expose all accounts as @accounts" do
      get :index, :format => 'fbml'
      response.should be_success
    end
  end
end  
