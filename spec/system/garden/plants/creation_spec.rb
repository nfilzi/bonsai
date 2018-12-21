require 'rails_helper'

describe 'Garden - Plant creation', type: :system do
  let(:user) { create(:user) }

  let(:photo_url) { 'https://www.truffaut.com/jardin/plantes-interieur/plantes-vertes-interieur/PublishingImages/dossiers-conseils/dc-sarracenias-plante-carnivore/sarracenias-b.jpg' }

  it 'lets a signed in user create new plant' do
    sign_in user
    visit '/garden/plants/new'
    # save_and_open_screenshot # debugging

    fill_in :plant_name,      with: 'Roxy'
    fill_in :plant_photo_url, with: photo_url
    select  2,                from: :plant_age_in_months
    select  'small',          from: :plant_size
    select  'living-room',    from: :plant_room
    # save_and_open_screenshot # debugging

    # preview of Plant photo url
    expect(page.find('#plant-image-preview')).to have_style('background-image': "url(\"#{photo_url}\")")

    click_button 'Create Plant'
    # save_and_open_screenshot # debugging

    expect(page).to have_current_path(garden_plant_path(Plant.last))

    expect(page).to have_content 'Roxy'
    expect(page).to have_content '2 months'
    expect(page).to have_content 'small size'
    expect(page).to have_content 'LIVING-ROOM'

    expect(page.find('.garden-plant img')['src']).to have_content(photo_url)
  end
end
