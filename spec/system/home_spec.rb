require 'rails_helper'

describe 'Homepage', type: :system do
  let(:user_bob)  { create(:user, nickname: 'Bob') }
  let(:user_elsa) { create(:user, nickname: 'Elsa') }

  let(:photo_url) { 'http://cdn.home-designing.com/wp-content/uploads/2017/01/indoor-house-plant-1024x679.jpg' }

  before :each do
    Plant.create!(user: user_bob,  name: 'Lekka',   photo_url: photo_url)
    Plant.create!(user: user_bob,  name: 'Cookie',  photo_url: photo_url)
    Plant.create!(user: user_elsa, name: 'Charlie', photo_url: photo_url)
    Plant.create!(user: user_elsa, name: 'Bidule',  photo_url: photo_url)
  end

  it 'shows last 3 plants' do
    visit '/'

    expect(page).to have_selector('.plant', count: 3)
    expect(page).to have_content 'by Elsa'
    expect(page).to have_content 'by Elsa'
    expect(page).to have_content 'by Bob'
  end

  describe 'cliking on the CTA' do
    context 'when user is signed in' do
      it 'redirects user to garden dashboard' do
        sign_in user_bob
        visit '/'
        click_on 'GET STARTED'

        expect(page).to have_current_path(garden_root_path)
      end
    end

    context 'when user is not signed in' do
      it 'stays on home page' do
        visit '/'
        click_on 'GET STARTED'

        expect(page).to have_current_path(root_path)
      end
    end
  end
end
