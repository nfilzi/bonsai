require 'rails_helper'

describe 'Garden - Care moment listing', type: :system do
  let(:user) { create(:user, plants: plants) }

  let(:plants) do
    [
      build(:plant,
        name: 'Rosie',
        care_points: 10,
        care_moments: [
          CareMoment.new(code: 'water', points: 10, date: '2018-12-17')
        ]
      ),
      build(:plant,
        name: 'Georges',
        care_points: 102,
        care_moments: [
          CareMoment.new(code: 'repot', points: 100, date: '2018-12-09'),
          CareMoment.new(code: 'water', points: 10,  date: '2018-12-20'),
          CareMoment.new(code: 'weed',  points:  2,  date: '2018-12-22')
        ]
      ),
    ]
  end

  it 'lets user see all the care moments he/she gave' do
    sign_in user
    visit '/garden/care_moments'

    expect(page).to have_selector('tbody tr', count: 4)

    care_moments = page.find_all('tbody tr')

    # date - plant - moment code - points
    expect(care_moments[0]).to have_content('Dec 22 Georges weed 2')
    expect(care_moments[1]).to have_content('Dec 20 Georges water 10')
    expect(care_moments[2]).to have_content('Dec 17 Rosie water 10')
    expect(care_moments[3]).to have_content('Dec 09 Georges repot 100')
  end
end
