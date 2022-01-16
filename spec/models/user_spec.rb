require 'rails_helper'

RSpec.describe User, type: :model do
  describe 'Validations' do

    it "is valid when given all attributes" do
      user = User.create(name: "Bob", email: "bob42@gmail.com", password: "loblaw", password_confirmation: "loblaw")
      expect(user.errors.full_messages).to be_empty
    end

    it "is invalid with no name" do
      user = User.create(email: "bob42@gmail.com", password: "loblaw")
      expect(user.errors.full_messages.first).to eq "Name can't be blank"
    end

    it "is invalid with no password" do
      user = User.create(name: "Bob", email: "bob42@gmail.com", password_confirmation: "loblaw")
      expect(user.errors.full_messages.first).to eq "Password can't be blank"
    end

    it "is invalid with no email" do
      user = User.create(name: "Bob", password: "loblaw", password_confirmation: "loblaw")
      expect(user.errors.full_messages.first).to eq "Email can't be blank"
    end

    it "is invalid when password and passsword confirmation are not matching" do
      user = User.create(name: "Bob", email: "bob42@gmail.com", password: "loblaw", password_confirmation: "nofrills")
      expect(user.errors.full_messages.first).to eq "Password confirmation doesn't match Password"
    end

    it "is invalid when password is less than 3 characters" do
      user = User.create(name: "Bob", email: "bob42@gmail.com", password: "no")
      expect(user.errors.full_messages.first).to eq "Password is too short (minimum is 3 characters)"
    end

    it "is invalid when email is not unique (Also if same email in caps)" do
      user1 = User.create(name: "Bob", email: "bob42@gmail.com", password: "loblaw")
      user2 = User.create(name: "Bob", email: "Bob42@gmail.com", password: "loblaw")
      expect(user2.errors.full_messages.first).to eq "Email has already been taken"
    end
  end

  describe '.authenticate_with_credentials' do
    it "logs in when given right credentials" do
      registerUser = User.create(name: "Bob", email: "bob42@gmail.com", password: "loblaw", password_confirmation: "loblaw")
      loginUser = User.authenticate_with_credentials("bob42@gmail.com", "loblaw")
      expect(loginUser).to_not be nil
    end

    it 'does not login with an incorrect email' do
      registerUser = User.create(name: "Bob", email: "bob42@gmail.com", password: "loblaw", password_confirmation: "loblaw")
      loginUser = User.authenticate_with_credentials("larry56@gmail.com", "loblaw")
      expect(loginUser).to be nil
    end

    it 'does not login with an incorrect password' do
      registerUser = User.create(name: "Bob", email: "bob42@gmail.com", password: "loblaw", password_confirmation: "loblaw")
      loginUser = User.authenticate_with_credentials( "bob42@gmail.com", "nofrills")
      expect(loginUser).to be nil
    end

    it 'logs in with an email with extra spaces' do
      registerUser = User.create(name: "Bob", email: "bob42@gmail.com", password: "loblaw", password_confirmation: "loblaw")
      loginUser = User.authenticate_with_credentials("  bob42@gmail.com   ", "loblaw")
      expect(loginUser).to_not be nil
    end

    it 'logs in with an email with different cases' do
      registerUser = User.create(name: "Bob", email: "bob42@gmail.com", password: "loblaw", password_confirmation: "loblaw")
      loginUser = User.authenticate_with_credentials('BOB42@gmail.com', 'loblaw')
      expect(loginUser).to_not be nil
    end
  end
end 
