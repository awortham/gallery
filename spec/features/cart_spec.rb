require 'rails_helper'
require 'capybara/poltergeist'

describe 'cart' do

    before do
      create(:item, categories: [create(:category)])
      visit '/'
      expect(page).to have_content "Oil of Ole"
      click_on 'Add to Cart'
      visit cart_path
      expect(page).to have_content "Your Cart"
      expect(page).to have_content "Oil of Ole"
    end

    context 'before user logs in' do

      it 'can remove an item from the cart' do
        click_on('Remove')
        expect(cart_path).to_not have_content 'Oil of Ole'
      end

      it 'can edit quantity of one item' do
        fill_in :quantity, with: "2"
        click_on 'Save'
        expect(page).to have_content '2'
      end

      it 'must log in to check out' do
        expect(page).to_not have_content 'How would you like to get your food?'
        expect(page).to have_content 'Login'
        expect(page).to have_content 'Create An Account'
      end
    end

    context 'after user logs in' do

      before do
        @user = create(:user)
        visit root_path
        find(:css, 'input#email.login-field').set(@user.email)
        find(:css, 'input#password.login-field').set(@user.password)
        click_on "Login"
      end

      describe 'chooses delivery' do

        before do
          visit cart_path
          expect(page).to have_content 'How would you like to get your food?'
          click_on('DELIVERY, please!')
          click_on('Enter Your Delivery Information')
          expect(page).to have_content 'Enter Your Delivery Information'
          fill_in 'Street number', with: "123"
          fill_in 'Street', with: " Sesame St."
          fill_in 'City', with: "Denver"
          select 'CO', from: 'State'
          fill_in 'Zip', with: "80206"
          click_on 'Save Address'
        end

        xit "can set delivery address", :js do
          expect(page).to have_content 'Review Your Order'
          expect(page).to have_content '123 Sesame St.'
        end

        it "can review order" do
          visit cart_path
          click_on("DELIVERY, please!")
          expect(page).to have_content 'Review Your Order'
          click_on 'Complete My Order'
          expect(page).to have_content 'Order Status: ordered'
        end

        it 'can cancel an order' do
          visit cart_path
          click_on("DELIVERY, please!")
          expect(page).to have_content 'Review Your Order'
          click_on 'Complete My Order'
          expect(page).to have_content "Order Status: ordered"
          click_on "Welcome, #{@user.username.capitalize}"
          click_on 'View Details'
          click_on 'Cancel This Order'
          expect(page).to have_content "cancelled"
        end
      end

      describe 'chooses pickup' do

        it "can review order" do
          visit cart_path
          click_on("I'll PICK IT UP")
          expect(page).to have_content 'Review Your Order'
          click_on 'Complete My Order'
          expect(page).to have_content 'Order Status: ordered'
        end
        
        it 'can cancel an order' do
          visit cart_path
          click_on("I'll PICK IT UP")
          expect(page).to have_content 'Review Your Order'
          click_on 'Complete My Order'
          expect(page).to have_content "Order Status: ordered"
          click_on "Welcome, #{@user.username.capitalize}"
          click_on 'View Details'
          click_on 'Cancel This Order'
          expect(page).to have_content "cancelled"
        end
      end
    end
  end
