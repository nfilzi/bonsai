require 'rails_helper'

describe 'Garden - Plant Favorite', type: :system do
  let(:user)  { create(:user) }
  let(:plant) { create(:plant, user: user, name: 'Fox') }

  context 'when plant is not favorited' do
    before :each do
      plant.update!(favorite: false)
    end

    it 'lets user mark it as favorite' do
      sign_in user
      visit "/garden/plants/#{plant.id}"

      # mark as favorite
      page.find('.favorite-link').click

      expect(page).to have_css('.favorite.active')
    end
  end

  context 'when plant is already favorited' do
    before :each do
      plant.update!(favorite: true)
    end

    it 'lets user mark it as not favorite' do
      sign_in user
      visit "/garden/plants/#{plant.id}"

      # mark as not favorite
      page.find('.favorite-link').click

      expect(page).not_to have_css('.favorite.active')
    end
  end
end
