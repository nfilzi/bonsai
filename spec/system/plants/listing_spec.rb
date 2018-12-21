require 'rails_helper'

describe 'Plants Listing', type: :system do
  let(:user_bob) { create(:user, nickname: 'Bob') }
  let(:user_lea) { create(:user, nickname: 'Lea') }

  before :each do
    # Bob
    @plant_bob_1 = create(:plant,
      name: 'Rex',
      user: user_bob,
      photo_url: 'http://dritare.net/wp-content/uploads/2018/01/20-2.jpeg'
    )
    @plant_bob_2 = create(:plant,
      name: 'Albus',
      user: user_bob,
      photo_url: 'https://www.home-dzine.co.za/2018/feb/301.jpg'
    )

    # Lea
    @plant_lea_1 = create(:plant,
      name: 'Dinges',
      user: user_lea,
      photo_url: 'https://i.ebayimg.com/images/g/EzUAAOSw-RFaZw33/s-l640.jpg'
    )
    @plant_lea_2 = create(:plant,
      name: 'Tchoup',
      user: user_lea,
      photo_url: 'http://cdn.junglecreations.com/wp/junglecms/2017/10/1-221.jpg'
    )
  end

  it 'lists all plants of all users' do
    visit '/plants'

    expect(page).to have_selector('.plant', count: 4)

    plants = page.find_all('.plant')

    expect(plants[0]).to have_content('by Lea')
    expect(plants[0].find('.plant-cover')).to have_style('background-image': "url(\"#{@plant_lea_2.photo_url}\")")

    expect(plants[1]).to have_content('by Lea')
    expect(plants[1].find('.plant-cover')).to have_style('background-image': "url(\"#{@plant_lea_1.photo_url}\")")

    expect(plants[2]).to have_content('by Bob')
    expect(plants[2].find('.plant-cover')).to have_style('background-image': "url(\"#{@plant_bob_2.photo_url}\")")

    expect(plants[3]).to have_content('by Bob')
    expect(plants[3].find('.plant-cover')).to have_style('background-image': "url(\"#{@plant_bob_1.photo_url}\")")
  end
end
