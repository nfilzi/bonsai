require 'rails_helper'

describe 'Garden - Care moment creation', type: :system do
  let(:user) { create(:user) }

  let(:plant) do
    create(:plant,
      user: user,
      name: 'Fox',
      care_points: 0
    )
  end

  it 'lets user create a care moment for the plant' do
    sign_in user
    visit "/garden/plants/#{plant.id}"

    page.find('.care-actions').click_on('water')

    expect(page.find('.care-overview')).to    have_content('10 doses')
    expect(page.find('.care-actions')).not_to have_content('water')
  end
end
