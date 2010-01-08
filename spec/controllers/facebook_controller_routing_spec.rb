require File.dirname(__FILE__) + '/../spec_helper'
describe FacebookController do
  describe "route generation" do
    it "should map {:controller=>'facebook', :action=>'authorized'} to /authorized" do
      route_for({:controller=>"facebook", :action=>"authorized"}).should == "/authorized"
    end

    it "should map {:controller=>'facebook', :action=>'authorize_redirect'} to /authorize_redirect" do
      route_for({:controller=>"facebook", :action=>"authorize_redirect"}).should == "/authorize_redirect"
    end

    it "should map {:controller=>'facebook', :action=>'installed'} to /installed" do
      route_for({:controller=>"facebook", :action=>"installed"}).should == "/installed"
    end

    it "should map {:controller=>'facebook', :action=>'privacy'} to /privacy" do
      route_for({:controller=>"facebook", :action=>"privacy"}).should == "/privacy"
    end

    it "should map {:controller=>'facebook', :action=>'uninstalled'} to /uninstalled" do
      route_for({:controller=>"facebook", :action=>"uninstalled"}).should == "/uninstalled"
    end

    it "should map {:controller=>'facebook', :action=>'help'} to /help" do
      route_for({:controller=>"facebook", :action=>"help"}).should == "/help"
    end
  end

  describe "route recognition" do
    it "should generate params {:controller=>'facebook', :action=>'authorized'} from get /authorized" do
      params_from(:get, "/authorized").should == {:controller=>'facebook', :action=>'authorized'}
    end
    it "should generate params {:controller=>'facebook', :action=>'authorized'} from get /authorize_redirect" do
      params_from(:get, "/authorize_redirect").should == {:controller=>'facebook', :action=>'authorize_redirect'}
    end
    it "should generate params {:controller=>'facebook', :action=>'installed'} from get /installed" do
      params_from(:get, "/installed").should == {:controller=>'facebook', :action=>'installed'}
    end
    it "should generate params {:controller=>'facebook', :action=>'privacy'} from get /privacy" do
      params_from(:get, "/privacy").should == {:controller=>'facebook', :action=>'privacy'}
    end
    it "should generate params {:controller=>'facebook', :action=>'uninstalled'} from get /uninstalled" do
      params_from(:get, "/uninstalled").should == {:controller=>'facebook', :action=>'uninstalled'}
    end
    it "should generate params {:controller=>'facebook', :action=>'help'} from get /help" do
      params_from(:get, "/help").should == {:controller=>'facebook', :action=>'help'}
    end
  end
end
