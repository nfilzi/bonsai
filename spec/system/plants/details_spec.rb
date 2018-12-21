require 'rails_helper'

describe 'Plant Details', type: :system do
  let(:user) { create(:user, nickname: 'Feiko', care_points: 30, level: 2) }

  let(:plant) do
    Plant.create!(
      user: user,
      name: 'Roek',
      age_in_months: 3,
      size: 'tall',
      room: 'bedroom',
      photo_url: photo_url,
      care_moments: care_moments
    )
  end

  let(:care_moments) do
    [
      CareMoment.new(code: 'water', points: 10, date: Date.today),
      CareMoment.new(code: 'water', points: 10, date: Date.today - 3.days),
      CareMoment.new(code: 'water', points: 10, date: Date.today - 1.week)
    ]
  end

  let(:photo_url) { 'https://i.pinimg.com/originals/a4/6c/20/a46c20e02baec84234f05f3e6e902ce0.jpg' }

  before :each do
    @other_plants = [
      Plant.create!(user: user, name: 'Natou', photo_url: 'https://images.pexels.com/photos/260046/pexels-photo-260046.jpeg'),
      Plant.create!(user: user, name: 'Mic',   photo_url: 'https://i.pinimg.com/originals/12/9a/77/129a7733bb7a05cb0aea95f62b1aab4b.jpg'),
    ]
  end

  it 'displays details of one plant' do
    visit "/plants/#{plant.id}"

    expect(page).to have_selector('h1', text: 'Roek')

    expect(page).to have_content('OWNED BY FEIKO')
    expect(page).to have_content('3 months old')
    expect(page).to have_content('so tall')
    expect(page).to have_content('bedroom')

    expect(page.first('.plant-cover')).to have_style('background-image': "url(\"#{photo_url}\")")

    # User's other plants
    expect(page).to have_selector('.plant', count: 2)

    actual_other_plants = page.find_all('.plant')
    expect(actual_other_plants[0].find('.plant-cover')).to have_style('background-image': "url(\"#{@other_plants[0].photo_url}\")")
    expect(actual_other_plants[1].find('.plant-cover')).to have_style('background-image': "url(\"#{@other_plants[1].photo_url}\")")
  end
end
