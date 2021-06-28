require 'rails_helper'

RSpec.describe User, type: :model do
  describe 'Validations' do
    it 'should create user if fields are valid' do
      @user =
        User.new(
          name: 'Zain Dewsi',
          email: 'zain.dewsi@gmail.com',
          password: 'password',
          password_confirmation: 'password',
        )

      @user.save

      expect(@user).to be_valid
    end
    it 'should fail if passwords do not match' do
      @user =
        User.new(
          name: 'Zain Dewsi',
          email: 'zain.dewsi@gmail.com',
          password: 'password',
          password_confirmation: 'pass',
        )

      @user.save

      expect(@user).not_to be_valid
    end

    it 'should fail if password is missing' do
      @user =
        User.new(
          name: 'Zain Dewsi',
          email: 'zain.dewsi@gmail.com',
          password: nil,
          password_confirmation: nil,
        )

      @user.save

      expect(@user).not_to be_valid
    end

    it 'should fail if password is less than 3 characters' do
      @user =
        User.new(
          name: 'Zain Dewsi',
          email: 'zain.dewsi@gmail.com',
          password: 'pa',
          password_confirmation: 'pa',
        )

      @user.save

      expect(@user).not_to be_valid
    end

    it 'should fail if user email already exists (not case sensitive)' do
      @user1 =
        User.new(
          name: 'Zain Dewsi',
          email: 'zain.dewsi@gmail.com',
          password: 'password',
          password_confirmation: 'password',
        )

      @user1.save

      @user2 =
        User.new(
          name: 'Zain Dewsi',
          email: 'ZAIN.dewsi@gmail.com',
          password: 'password',
          password_confirmation: 'password',
        )

      @user2.save

      expect(@user2).not_to be_valid
    end

    it 'should fail if user email is invalid' do
      @user =
        User.new(
          name: 'Zain Dewsi',
          email: nil,
          password: 'password',
          password_confirmation: 'password',
        )

      @user.save

      expect(@user).not_to be_valid
    end

    it 'should fail if user name is invalid' do
      @user =
        User.new(
          name: nil,
          email: 'zain.dewsi@gmail.com',
          password: 'password',
          password_confirmation: 'password',
        )

      @user.save

      expect(@user).not_to be_valid
    end
  end

  describe '.authenticate_with_credentials' do
    it 'should be valid with valid credentials' do
      @user =
        User.new(
          name: 'Zain Dewsi',
          email: 'zain.dewsi@gmail.com',
          password: 'password',
          password_confirmation: 'password',
        )

      @user.save

      loggedUser =
        User.authenticate_with_credentials(@user.email, @user.password)

      expect(loggedUser.id).to be (@user.id)
    end

    it 'should ignore whitespace in email field' do
      @user =
        User.new(
          name: 'Zain Dewsi',
          email: 'zain.dewsi@gmail.com',
          password: 'password',
          password_confirmation: 'password',
        )

      @user.save

      loggedUser =
        User.authenticate_with_credentials(
          '   zain.dewsi@gmail.com',
          @user.password,
        )

      expect(loggedUser.id).to be (@user.id)
    end

    it 'should ignore case in user email field' do
      @user =
        User.new(
          name: 'Zain Dewsi',
          email: 'zain.dewsi@gmail.com',
          password: 'password',
          password_confirmation: 'password',
        )

      @user.save

      loggedUser =
        User.authenticate_with_credentials(
          'ZAin.deWsi@gmail.com',
          @user.password,
        )

      expect(loggedUser.id).to be (@user.id)
    end
  end
end
