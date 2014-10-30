require 'rails_helper'

describe 'browse images' do

    xit 'correctly directs user to browse page' do
      visit root_path
      click_on('Browse')
      expect(page).to have_content 'All Items'

    end

end
