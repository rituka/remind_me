class Account < ActiveRecord::Base  
  named_scope :active, :conditions => { :active => true }

  # Virtual attribute for when we need to associate a FB Session record with our model
  attr_accessor :facebook_account

  def to_param
    facebook_uid.to_s
  end

  def uninstall
    update_attributes(:active => false)
  end

  class <<self
    def find_or_create_by_facebook_params(u)
      account = find_or_initialize_by_facebook_uid(:is_app_user => true, :facebook_uid => u.uid.to_i, :active => true)
      account.active = true
      account.save
      account
    end
  end
end
