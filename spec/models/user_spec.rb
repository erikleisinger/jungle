require 'rails_helper'

RSpec.describe User, type: :model do
  describe "Validations" do
    it "should have matching password and password_confirmation fields" do
      @user = User.create(:name => 'Erik', :email => 'erik@erik.com', :password => '1234567', :password_confirmation => '1234567')
      @user.save
      expect(User.where(name: 'Erik')).to exist
    end
    it "should throw an error when passwords do not match" do
      @user = User.new(:name => 'Erik', :email => 'erik@erik.com', :password => '1234567', :password_confirmation => '12345678')
      @user.save
      expect(@user.errors.full_messages).to include("Password confirmation doesn't match Password")
    end
    it "should throw an error if email is already in use" do
      @user1 = User.new(:name => 'Mike', :email => 'erik@erik.com', :password => '1234567', :password_confirmation => '1234567')
      @user2 = User.new(:name => 'Erik', :email => 'erik@erik.com', :password => '1234567', :password_confirmation => '1234567')
      @user1.save
      @user2.save
      expect(@user2.errors.full_messages).to include("Email already taken")
      expect(User.where(name: 'Mike')).to exist
    end
    it "should throw an error if email already in use -- not case sensitive" do
      @user1 = User.new(:name => 'Mike', :email => 'erik@erik.com', :password => '1234567', :password_confirmation => '1234567')
      @user2 = User.new(:name => 'Erik', :email => 'ERIK@ERIK.com', :password => '1234567', :password_confirmation => '1234567')
      @user1.save
      @user2.save
      expect(@user2.errors.full_messages).to include("Email already taken")
      expect(User.where(name: 'Mike')).to exist
    end
    it "should throw an error if no name provided" do
      @user1 = User.new(:name => nil, :email => 'erik@erik.com', :password => '1234567', :password_confirmation => '1234567')
      @user1.save
      expect(@user1.errors.full_messages).to include("Name can't be blank")
    end
    it "should throw an error if no email provided" do
      @user1 = User.new(:name => 'Mike', :email => nil, :password => '1234567', :password_confirmation => '1234567')
      @user1.save
      expect(@user1.errors.full_messages).to include("Email can't be blank")
    end
    it "should throw an error if no password provided" do
      @user1 = User.new(:name => 'Mike', :email => 'erik@erik.com', :password => nil, :password_confirmation => '1234567')
      @user1.save
      expect(@user1.errors.full_messages).to include("Password can't be blank")
    end
    it "should throw an error if password confirmation is not provided" do
      @user1 = User.new(:name => 'Mike', :email => 'erik@erik.com', :password => '1234567', :password_confirmation => nil)
      @user1.save
      expect(@user1.errors.full_messages).to include("Password confirmation can't be blank")
    end
    it "should throw an error if the password is less than 7 characters" do
      @user1 = User.new(:name => 'Mike', :email => 'erik@erik.com', :password => '123456', :password_confirmation => nil)
      @user1.save
      expect(@user1.errors.full_messages).to include("Password is too short (minimum is 7 characters)")
    end
  end

  describe ".authenticate_with_credentials" do
    it "should return nil if the user does not exist" do
      expect(User.authenticate_with_credentials('nil@nil.com', '123')).to be_nil
    end
    it "should return the user if the user exists" do
      @user = User.new(:name => 'Mike', :email => 'erik@erik.com', :password => '1234567', :password_confirmation => '1234567')
      @user.save
      expect(User.authenticate_with_credentials('erik@erik.com', '1234567').get_email).to match('erik@erik.com')
    end
    it "should validate a users email even if there is whitespace before or after " do
      @user = User.new(:name => 'Mike', :email => 'erik@erik.com', :password => '1234567', :password_confirmation => '1234567')
      @user.save
      expect(User.authenticate_with_credentials('     erik@erik.com    ', '1234567').get_email).to match('erik@erik.com')
    end
    it "should not be case sensitive when authenticating email" do
      @user = User.new(:name => 'Mike', :email => 'erik@erik.com', :password => '1234567', :password_confirmation => '1234567')
      @user.save
      expect(User.authenticate_with_credentials('ERiK@ErIK.COM', '1234567').get_email).to match('erik@erik.com')
    end
  end
end
