require 'rails_helper'

RSpec.describe User, type: :model do
  
  before(:each) do
    @user = User.create!(
      :first_name => 'Test',
      :last_name => 'McTest',
      :email => 'test@test.com',
      :password => 'password',
      :password_confirmation => 'password'
    )
  end

  describe 'Validations' do
    it 'must have a first name' do
      expect(@user).to have_attributes(:first_name => anything)
    end

    it 'must have a last name' do
      expect(@user).to have_attributes(:last_name => anything)
    end

    it 'must have a unique, case insensitive email' do
      expect(@user).to have_attributes(:email => anything)
    end

    it 'must be created with a password and confirmation field' do
      sep_user = User.new(
        :first_name => 'Test',
        :last_name => 'McTest',
        :email => 'test1@test.com',
        :password => 'password'
      )
      expect{ sep_user.save! }.to raise_error(ActiveRecord::RecordInvalid)
    end

    it 'must have matching password and confirmation fields' do
      sep_user = User.new(
        :first_name => 'Test',
        :last_name => 'McTest',
        :email => 'test1@test.com',
        :password => 'password',
        :password_confirmation => 'password'
      )
      expect(sep_user.password).to eq(sep_user.password_confirmation)

      sep_user = User.new(
        :first_name => 'Test',
        :last_name => 'McTest',
        :email => 'test1@test.com',
        :password => 'password',
      )
      expect(sep_user.password).not_to eq(sep_user.password_confirmation)
    end

    it 'must have a password of at least 6 characters' do
      sep_user = User.new(
        :first_name => 'Test',
        :last_name => 'McTest',
        :email => 'test4@test.com',
        :password => 'pas',
        :password_confirmation => 'pas'
      )
      expect{ sep_user.save! }.to raise_error(ActiveRecord::RecordInvalid)

      sep_user = User.new(
        :first_name => 'Test',
        :last_name => 'McTest',
        :email => 'test4@test.com',
        :password => 'password',
        :password_confirmation => 'password'
      )
      expect{ sep_user.save! }.not_to raise_error
    end

    it 'should return the correct user given their credentials' do
      expect(
        User.authenticate_with_credentials('test@test.com', 'password')
      ).to be_a(User)
    end

    it 'should ignore excessive white space or uppercase on login' do
      expect(
        User.authenticate_with_credentials('    TeSt@test.Com  ', 'password')
      ).to be_a(User)
    end
  end
end
