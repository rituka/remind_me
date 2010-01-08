require File.expand_path(File.dirname(__FILE__) + '/../spec_helper')

describe Account do
  fixtures :accounts
  before(:each) do
    @facebook_account = accounts(:new_facebook_user)
    @valid_attributes = {
      :facebook_uid => "123456",
      :active => false
    }
  end

  it "should create a new instance given valid attributes" do
    lambda do
      Account.create!(@valid_attributes)
    end.should change(Account, :count).by(1)
  end

  it "should deactive the account" do
    @facebook_account.uninstall.should == true
    @facebook_account.reload.active.should == false
  end
end
