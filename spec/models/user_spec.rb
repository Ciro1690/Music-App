require 'rails_helper'

RSpec.describe User, type: :model do
  subject(:user) do
    User.create!(email: "123@test.com", password: "good_password")
  end

  describe "validations" do
    it { should validate_presence_of(:email)}
    it { should validate_presence_of(:password_digest)}
    it { should validate_length_of(:password).is_at_least(6) }

    it "creates a password digest when a password is given" do
      expect(user.password_digest).to_not be_nil
    end

    it "creates a session token" do
      expect(user.session_token).to_not be_nil
    end
  end


  describe "is_password?" do 
    it "verifies a good password" do
      expect(user.is_password?("good_password")).to be true
    end
    
    it "does not verify a bad password" do
      expect(user.is_password?("bad_password")).to be false    
    end
  end

  describe "#reset_session_token!" do
    it "sets a new session_token on the user" do
      old_session_token = user.session_token
      user.reset_session_token!
      expect(user.session_token).to_not eq(old_session_token)
    end

    it "returns the new session token" do
      expect(user.reset_session_token!).to eq(user.session_token)
    end
  end

  describe "::find_by_credentials" do
    before { user.save! }

    it "returns a user given good credentials" do 
      expect(User.find_by_credentials("123@test.com", "good_password")).to eq(user)
    end

    it "doesn't return a user with bad credentials" do
      expect(User.find_by_credentials("124@test.com", "bad_password")).to eq(nil)
    end
  end
end
