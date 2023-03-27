class UsersController < ApplicationController
  before_action :authenticate_user!
  before_action :ensure_user, only: [:edit, [:update]]

  def show
    @user = User.find(params[:id])
    @books = @user.books
    @book = Book.new
  end

  def index
    @book = Book.new
    @users = User.all
  end

  def edit
  end

  def update
    @user = User.find(params[:id])
    if @user.update(user_params)
      flash[:notice] = "You have updated user successfully."
      redirect_to user_path(@user.id)
    else
      render :edit
    end
  end

  private
  def user_params
    params.require(:user).permit(:name, :profile_image, :introduction)
  end
  
  def ensure_user
    @user = User.find(params[:id])
    unless @user == current_user
      redirect_to user_path(current_user)
    end
  end

end
