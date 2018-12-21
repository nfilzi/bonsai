require 'rails_helper'

describe 'Garden - Plant deletion', type: :system do
  let(:user)  { create(:user) }
  let(:plant) { create(:plant, user: user, name: 'Nookie') }

  it 'lets user delete one plant' do
    sign_in user
    visit "/garden/plants/#{plant.id}"

    accept_alert do
      click_on 'remove'
    end

    expect(page).to     have_current_path(garden_plants_path)
    expect(page).not_to have_content('Nookie')
  end
end
