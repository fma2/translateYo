class UsersController < ApplicationController
  before_action :authenticate_user!, :except => [:index]  

  def index
    redirect_to :root
  end

  def test
    flash[:notice] = true
    redirect_to '/'
  end

  def login
    @user = User.find_by(email: params[:user][:email])
    if user_signed_in?
      session[:user] = @user.id
      redirect_to user_ratings_path(@user), flash: {notice: "Successful log in!"}
    else
      redirect_to users_path, flash: {notice: 'Invalid credentials!' }
    end
  end

  def new
    @user = User.new
  end

  def create
    @user = User.new(user_params(params))
    if @user.save
      session[:user] = @user.id
      redirect_to user_ratings_path(@user), flash: {notice: 'Successful log in!'}
    else
      redirect_to new_user_path, flash: {notice: 'Failed'}
    end
  end

  def sign_out
    session.clear
    redirect_to "/"
  end

  def show
      @user = User.find(params[:id])
  end

 private

  def user_params(params)
    params.require(:user).permit(:name, :email, :password)
  end

end