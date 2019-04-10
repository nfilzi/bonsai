require 'rails_helper'

RSpec.describe User, type: :model do
  subject(:user) do
    build(:users)
  end

  it "owns many plants" do
    expect(user).to have_many(:plants)
  end

  it "has many care moments" do
    expect(user).to have_many(:care_moments)
  end
end
