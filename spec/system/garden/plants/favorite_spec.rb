require 'rails_helper'

RSpec.describe 'Garden - Plants - Favorite', type: :system do
  let(:plant) { create(:plants, :with_owner) }

  it 'allows user to mark a plant as favorite' do
    sign_in plant.owner

    visit garden_plant_path(plant)

    find('a.favorite-plant').click

    expect(page).to have_css('.favorite-label')
  end
end
