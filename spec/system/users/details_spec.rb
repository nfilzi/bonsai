require 'rails_helper'

describe 'User page', type: :system do
  let(:user) do
    create(:user,
      nickname: 'Melinda',
      level: 1,
      care_points: 22,
      plants: plants
    )
  end

  let(:plants) do
    [
      Plant.new(
        name: 'Rosie',
        age_in_months: 1,
        size: :small,
        room: 'bedroom',
        care_moments: [
          CareMoment.new(code: 'water', points: 10),
          CareMoment.new(code: 'weed', points: 2),
        ]
      ),
      Plant.new(
        name: 'Rex',
        age_in_months: 3,
        size: :medium,
        room: 'living-room',
        care_moments: [
          CareMoment.new(code: 'water', points: 10),
        ]
      )
    ]
  end

  it 'shows user public profile page' do
    visit "/users/#{user.id}"

    expect(page).to have_content 'Melinda'
    expect(page).to have_content 'level 1'
    expect(page).to have_content '22 doses of care'
    expect(page).to have_content '2 plants'
    expect(page).to have_selector('.plant', count: 2)
  end
end
