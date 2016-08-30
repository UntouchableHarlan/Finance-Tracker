class UsersController < ApplicationController
  before_action :require_user, only: [:my_portfolio]

  def new
    @user = User.new
  end

  def my_portfolio
  end

  def create
    @user = User.new(user_params)
      if @user.save
        session[:user_id] = @user.id
        redirect_to root_path
      else
        render 'new'
      end
  end

  private

  def user_params
    params.require(:user).permit(:name, :email, :password, :password_confirmation)
  end
end
