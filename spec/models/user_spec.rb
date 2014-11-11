require 'rails_helper'

describe 'valid user' do
  let(:user) { create(:user, name: 'Joe', email: 'joe@example.com', username: 'joejoe', role: 'registered', password: '1234', password_confirmation: '1234', business_id: 1) }

  it "is valid" do
    expect(user).to be_valid
  end

  it 'has a valid email' do
    user.email = ''
    expect(user).to_not be_valid
  end

  it "is invalid without a name" do
    expect(user.name).to eq 'Joe'

    user.name = ''
    expect(user).to_not be_valid
  end

  it "is invalid without an email" do
    user.email = nil
    expect(user).to_not be_valid
  end

  it "is invalid without a role" do
    user.role = nil
    expect(user).to_not be_valid
  end

  it "has a valid email" do
    user.email = "abc,example.com"
    expect(user).to_not be_valid

    user.email = "someone@asd"
    expect(user).to_not be_valid

    user.email = "abc1@example.com"
    expect(user).to be_valid
  end

  it "has a unique email within one business" do
    second_user = user.dup
    second_user.save
    expect(second_user).to_not be_valid
  end

  it "does not allow a username less than 2 or more than 32 characters" do
    expect(user).to be_valid

    user.username = nil
    expect(user).to be_valid

    user.username = ""
    expect(user).to be_valid

    user.username = "a"
    expect(user).to_not be_valid

    user.username = "aa"
    expect(user).to be_valid

    user.username = "#{'a'*32}"
    expect(user).to be_valid

    user.username = "#{'a'*33}"
    expect(user).to_not be_valid
  end

  it "can create an account with a second business that has the same email" do
    second_user = user.dup
    second_user.business_id = 2
    expect(second_user).to be_valid
  end

  describe "#platform_admin?" do
    it "has the method" do
      expect(user.platform_admin?).to eq(false)
    end
  end

  describe "#default_url" do
    it "returns proper URL for platform admin" do
      user.update_attributes(role: 'platform_admin')
      expect(user.default_url).to eq('/platform')
    end
  end
end
