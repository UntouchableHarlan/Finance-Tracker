class UsersController < ApplicationController
  before_action :require_user, only: [:my_portfolio]

  def new
    @user = User.new
  end

  def edit
    @user = User.find(params[:id])
  end

  def show
    @user = User.find(params[:id])
  end

  def my_portfolio
  end

  def connect
    @friendships = current_user.friends
  end
# -----------------------------------------------------------
  def search
     @users = User.search(params[:search_param])
     respond_to do |format|
       if @users
         @users = current_user.execpt_current_user(@users)
         format.html { render partial: "friends/lookup" }
         format.json { render json: @users }
       else
         format.json { render status: :not_found, nothing: true }
       end
     end
  end

  def add_friend
    @friend = User.find(params[:friend])
    current_user.friendships.build(friend_id: @friend.id)

    if current_user.save
      redirect_to connect_path, notice: "Friend was successfully added"
    else
      redirect_to connect_path
      flash[:error] = "Error adding friend"
    end
  end
# -----------------------------------------------------------
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
