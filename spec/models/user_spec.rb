require 'rails_helper'

RSpec.describe User, type: :model do
  describe "validations" do
    
    it "is valid with valid attributes" do
      @user = User.new(first_name: "John", last_name: "Doe", email: "john@example.com", password: "12345", password_confirmation: "12345")
      expect(@user).to be_valid
    end

    it "it must be created with a first name" do
      @user = User.new(first_name: nil, last_name: "Doe", email: "john@example.com", password: "12345", password_confirmation: "12345")
      expect(@user).to_not be_valid
      expect(@user.errors.full_messages).to include("First name can't be blank")
    end

    it "it must be created with a last name" do
      @user = User.new(first_name: "John", last_name: nil, email: "john@example.com", password: "12345", password_confirmation: "12345")
      expect(@user).to_not be_valid
      expect(@user.errors.full_messages).to include("Last name can't be blank")
    end

    it "it must be created with an email" do
      @user = User.new(first_name: "John", last_name: "Doe", email: nil, password: "12345", password_confirmation: "12345")
      expect(@user).to_not be_valid
      expect(@user.errors.full_messages).to include("Email can't be blank")
    end

    it "it must be created with a unique email" do
      @user = User.new(first_name: "John", last_name: "Doe", email: "john@example.com", password: "12345", password_confirmation: "12345")
      @user.save!
      @user1 = User.new(first_name: "Jane", last_name: "Doe", email: "JOHN@example.com", password: "54321", password_confirmation: "54321")
      expect(@user1).to_not be_valid
      expect(@user1.errors.full_messages).to include("Email has already been taken")
    end

    it "it must be created with password and password confirmation fields" do
      @user = User.new(first_name: "John", last_name: "Doe", email: "john@example.com", password: nil, password_confirmation: nil)
      expect(@user).to_not be_valid
      expect(@user.errors.full_messages).to include("Password can't be blank")
    end

    it "password and password confirmation fields must match" do
      @user = User.new(first_name: "John", last_name: "Doe", email: "john@example.com", password: "12345", password_confirmation: "ABCXYZ")
      expect(@user).to_not be_valid
      expect(@user.errors.full_messages).to include("Password confirmation doesn't match Password")
    end

    it "password must be at least 5 characters in length" do
      @user = User.new(first_name: "John", last_name: "Doe", email: "john@example.com", password: "123", password_confirmation: "123")
      expect(@user).to_not be_valid
      expect(@user.errors.full_messages).to include("Password is too short (minimum is 5 characters)")
    end

  end
end
