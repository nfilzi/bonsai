require 'rails_helper'

describe 'Garden - Plant edition', type: :system do
  let(:user) { create(:user, plants: [plant]) }

  let(:plant) do
    Plant.new(
      name: 'Rosie',
      age_in_months: 2,
      size: 'small',
      room: 'entrance',
      photo_url: 'https://images.pexels.com/photos/260046/pexels-photo-260046.jpeg'
    )
  end

  let(:photo_url) { 'https://i.pinimg.com/originals/a4/6c/20/a46c20e02baec84234f05f3e6e902ce0.jpg' }

  it 'lets user editing one of his/her plants' do
    sign_in user
    visit "/garden/plants/#{plant.id}/edit"

    fill_in :plant_name,      with: 'Rosetta'
    fill_in :plant_photo_url, with: photo_url
    select  3,                from: :plant_age_in_months
    select  'medium',         from: :plant_size
    select  'bathroom',       from: :plant_room

    click_button 'Update Plant'

    expect(page).to have_current_path(garden_plant_path(Plant.last))

    expect(page).to have_content 'Rosetta'
    expect(page).to have_content '3 months'
    expect(page).to have_content 'medium size'
    expect(page).to have_content 'BATHROOM'

    expect(page.find('.garden-plant img')['src']).to have_content(photo_url)
  end
end
