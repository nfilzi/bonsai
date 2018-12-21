require 'rails_helper'

describe 'Garden - Plant details', type: :system do
  let(:user) { create(:user) }

  let(:photo_url) { 'https://i.pinimg.com/originals/e2/06/5d/e2065d88f1d3be53dcd7b48df2e05c50.jpg' }

  let(:plant) do
    create(:plant,
      user: user,
      name: 'Albus',
      photo_url: photo_url,
      age_in_months: 11,
      size: 'tall',
      room: 'office',
      care_points: 102,
      care_moments: [
        CareMoment.new(code: 'water', points: 10,  date: '2018-11-05'),
        CareMoment.new(code: 'weed',  points: 2,   date: '2018-12-15'),
        CareMoment.new(code: 'repot', points: 100, date: '2018-12-21')
      ]
    )
  end

  it 'lets user see details of one of his/her plants' do
    sign_in user
    visit "/garden/plants/#{plant.id}"

    expect(page).to have_content 'Albus'
    expect(page).to have_content '11 months'
    expect(page).to have_content 'tall size'
    expect(page).to have_content 'OFFICE'

    expect(page.find('.garden-plant img')['src']).to have_content(photo_url)

    expect(page).to have_selector('.plant-care-moments tbody tr', count: 3)

    care_moments = page.find_all('.plant-care-moments tbody tr')

    expect(care_moments[0]).to have_content('1 Dec 21 repot 100')
    expect(care_moments[1]).to have_content('2 Dec 15 weed 2')
    expect(care_moments[2]).to have_content('3 Nov 05 water 10')
  end
end
