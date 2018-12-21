require 'rails_helper'

describe 'Leaderboard', type: :system do
  before :each do
    # 2nd user
    @user_2 = create(:user, nickname: 'Bob', care_points: 30, level: 2)
    plant = Plant.create!(user: @user_2, name: 'Robert')
    CareMoment.create!(plant: plant, code: 'water', points: 10, date: Date.today)
    CareMoment.create!(plant: plant, code: 'water', points: 10, date: Date.today - 3.days)
    CareMoment.create!(plant: plant, code: 'water', points: 10, date: Date.today - 1.week)

    # 1st user
    @user_1 = create(:user, nickname: 'Janis', care_points: 122, level: 3)
    plant_1 = Plant.create!(user: @user_1, name: 'Jimy')
    plant_2 = Plant.create!(user: @user_1, name: 'Alanis')
    plant_3 = Plant.create!(user: @user_1, name: 'Jason')
    CareMoment.create!(plant: plant_1, code: 'repot', points: 100, date: Date.today)
    CareMoment.create!(plant: plant_1, code: 'water', points: 10, date: Date.today - 3.days)
    CareMoment.create!(plant: plant_2, code: 'water', points: 10, date: Date.today - 1.week)
    CareMoment.create!(plant: plant_3, code: 'weed', points: 2, date: Date.today - 1.week)

    # 4th user
    @user_4 = create(:user, nickname: 'Alice', care_points: 10, level: 1)
    plant = Plant.create!(user: @user_4, name: 'Daniel')
    CareMoment.create!(plant: plant, code: 'water', points: 10, date: Date.today)

    # 3rd user
    @user_3 = create(:user, nickname: 'John', care_points: 12, level: 1)
    plant_1 = Plant.create!(user: @user_3, name: 'Adele')
    plant_2 = Plant.create!(user: @user_3, name: 'Line')
    CareMoment.create!(plant: plant_1, code: 'water', points: 10, date: Date.today)
    CareMoment.create!(plant: plant_2, code: 'weed', points: 2, date: Date.today)
  end

  it 'displays all users sorted by top level and care points' do
    sign_in @user_1
    visit '/leaderboard'

    expect(page).to have_selector('tbody tr', count: 4)

    top_user_1, top_user_2, top_user_3, top_user_4 = *page.find_all('tbody tr')

    # Medal - Nickname - Plants - Moments - Points - Level
    expect(top_user_1).to have_content('🥇 Janis 3 4 122 3')
    expect(top_user_2).to have_content('🥈 Bob 1 3 30 2')
    expect(top_user_3).to have_content('🥉 John 2 2 12 1')
    expect(top_user_4).to have_content('🏅 Alice 1 1 10 1')
  end
end
