require 'rails_helper'

RSpec.describe 'Homepage', type: :system do
  before :each do
    plants = create_list(:plants, 4, :with_owner).sort_by(&:created_at).reverse

    @three_latest_plants = plants.first(3)
  end

  it 'shows the app welcoming message' do
    expect(page).to have_content 'Bonsai!'
    expect(page).to have_content 'Take care of your plants on a daily basis'
  end

  it 'shows only the 3 latest plants' do
    visit '/'

    plants_cards = all(".home-plants .plant")
    owners_names = plants_cards.map { |plant_card| plant_card.find('.plant-owner').text.gsub('by ', '') }

    expect(@three_latest_plants.map {|plant| plant.owner.nickname }).to eq(owners_names)
  end
end
