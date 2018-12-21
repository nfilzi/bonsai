require 'rails_helper'

describe 'Garden - Plant listing', type: :system do
  let(:user) { create(:user, plants: plants) }

  let(:plants) do
    [
      build(:plant, name: 'Rosie',   care_points: 10),
      build(:plant, name: 'Georges', care_points: 42),
    ]
  end

  before :each do
    @other_user_plant = create(:plant, name: 'Other user plant', user: create(:user))
  end

  it 'displays user plants' do
    sign_in user
    visit '/garden/plants'

    # plants
    expect(page).to have_selector('.garden-plant', count: 2)

    plant_1, plant_2 = *page.find_all('.garden-plant')

    # plant 1 (ordered by name)
    expect(plant_1).to have_content('Georges')
    expect(plant_1).to have_content('42 doses')
    # plant 2
    expect(plant_2).to have_content('Rosie')
    expect(plant_2).to have_content('10 doses')

    # no other user plant
    expect(page).not_to have_content('Other user plant')

    expect(page).to have_link('New Plant', href: new_garden_plant_path)
  end
end
