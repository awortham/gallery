require 'rails_helper'

describe 'create user' do

  before do
    @business = Business.create(slug: "joesphotography")
    @user = User.create(name: 'joe', email: 'joe@example.com', username: 'joe', password: 'password', password_confirmation: 'password', business_id: @business.id)
    visit(new_user_path(@business.slug))
  end

  it 'creates a new user' do
    within(:css, "#register") do
      fill_in 'Name',             with: 'happyuser'
      fill_in 'Email',            with: 'happyuser@example.com'
      fill_in 'Username',         with: 'happyuser'
      fill_in 'Password',         with: '1111'
      fill_in 'Confirm Password', with: '1111'
      click_on('Create Account')
    end

    expect(page).to have_content 'Happyuser'
    expect(page).to have_content 'Logout'
  end

  it 'cannot create user if username is taken' do
    within(:css, "#register") do
      fill_in 'Name',             with: 'joe'
      fill_in 'Email',            with: 'joe@example.com'
      fill_in 'Username',         with: 'joe'
      fill_in 'Password',         with: 'password'
      fill_in 'Confirm Password', with: 'password'
      click_on('Create Account')
    end

    expect(page).to  have_css('#email')
  end


  it "cannot create user if password doesn't match password confirmation" do
    within(:css, "#register") do
      fill_in 'Name',             with: 'user'
      fill_in 'Email',            with: 'user@example.com'
      fill_in 'Username',         with: 'user'
      fill_in('Password',         with: '1111')
      fill_in('Confirm Password', with: '9999')
      click_on('Create Account')
    end


    expect(page).to have_selector ("#password")
    expect(page).to_not have_content 'Logout'
  end

end

describe 'user login' do

  before do
    @business = Business.create(slug: "joshgoldphotography", name: "jbiz", id: 4)
    @user = User.create(username: "Jonycage", name: "Joe", password: "1234", password_confirmation: "1234", email: "jony@comelately.com", business_id: 4)
    visit home_path(@business.slug)
    p @business
  end

  it "can log in a user with an established username and password" do
    within(:css, "#nav_bar") do
      fill_in 'email',     with: "#{@user.email}"
      fill_in 'password', with: "#{@user.password}"
      click_on 'Login'
    end

    expect(page).to have_content "Welcome, #{@user.username}"
  end


  it 'successfully logs out user' do
    within(:css, "#nav_bar") do
      fill_in 'email',     with: "#{@user.email}"
      fill_in 'password', with: "#{@user.password}"
      click_on('Login')
    end

    click_on('Logout')
    expect(page).to_not have_content("Welcome, #{@user.username}")
  end


  it 'cannot login with incorrect password' do
    within(:css, "#nav_bar") do
      fill_in 'email',     with: "#{@user.email}"
      fill_in 'password', with: "incorrectpassword"
      click_on('Login')
    end

    expect(page).to have_selector(".login-field")
  end


  it 'cannot login with incorrect username' do
    within(:css, "#nav_bar") do
      fill_in 'email',     with: "incorrectemail@example.com"
      fill_in 'password', with: "#{@user.password}"
      click_on('Login')
    end

    expect(page).to have_selector(".login-field")
  end
end



# describe 'user settings', :type => :feature, :js => true do
describe 'user settings' do

  before do
    business = Business.create(slug: "joshgoldphotography", name: "jbiz", id: 5)
    @user = User.create(username: "Lil Jess", name: "Jessica", password: "5555", password_confirmation: "5555", email: "jess@gmail.com", business_id: 5)
    visit home_path(business.slug)
    within(:css, "#nav_bar") do
      fill_in'email',     with: "#{@user.email}"
      fill_in'password', with: "#{@user.password}"
      click_on('Login')
    end
  end

  it 'correctly directs user to settings show page' do
    click_on('Settings')
    expect(page).to have_content 'My Account Settings'
  end


  it 'allows user to edit user settings' do
    within(:css, "#nav_bar") do
      click_on('Settings')
    end

    click_on('Edit Account Details')
    fill_in 'Name', with: 'NewName'
    click_on('Update Account')

    expect(page).to have_content 'Welcome, Lil Jess'
    expect(page).to have_content 'Account Settings'
    expect(page).to_not have_content "Jessica"
  end

  it 'deletes a user account when requested' do
    within(:css, "#nav_bar") do
      click_on('Settings')
    end

    click_on('Edit Account Details')
    click_on('Delete Account')

    expect(page).to have_selector'.login-field'
  end
end
