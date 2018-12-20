class UsersController < ApplicationController
  skip_before_action :authenticate_user!

  def show
    @user   = User.find(params[:id])
    @plants = @user.plants.order(:name)
  end
end
