require 'rails_helper'

RSpec.describe 'Homepage', type: :system do
  it 'shows the app welcoming message' do
    visit '/'

    expect(page).to have_content 'Bonsai!'
    expect(page).to have_content 'Take care of your plants on a daily basis'
  end

  it 'shows only the 3 latest plants' do
    plants = create_list(:plants, 4, :with_owner).sort_by(&:created_at).reverse
    three_latest_plants = plants.first(3)

    visit '/'

    plants_cards = all(".home-plants .plant")
    owners_names = plants_cards.map { |plant_card| plant_card.find('.plant-owner').text.gsub('by ', '') }

    expect(three_latest_plants.map {|plant| plant.owner.nickname }).to eq(owners_names)
  end

  context 'when user is connected' do
    let(:user) { create(:users) }

    it 'shows a CTA in banner to the user garden' do
      sign_in user
      visit '/'

      expect(page).to have_link 'GET STARTED', href: garden_root_path
    end
  end

  context 'when user is not connected' do
    it 'shows a CTA in banner to the plants index page' do
      visit '/'

      expect(page).to have_link 'GET STARTED', href: plants_path
    end
  end
end
