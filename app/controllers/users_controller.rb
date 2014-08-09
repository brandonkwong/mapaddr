class UsersController < ApplicationController

  def index
    if current_user
      @groups = current_user.groups.all
      @group = current_user.groups.new
      @locations = @group.locations
      @location = Location.new
    else
      redirect_to welcome_path
    end
  end

  def show
    @user = User.find(params[:id])
    @groups = @user.groups.all
  end

  def edit
    if current_user && current_user.id == User.find(params[:id]).id
      @user = User.find(params[:id])
    else
      redirect_to welcome_path
    end
  end

  def update
    @user = User.find(params[:id])
    if @user.update_attributes(params.require(:user).permit(:name, :email, :password, :password_confirmation))
      redirect_to root_path
    else
      render 'edit'
    end
  end

  def destroy
    reset_session
    User.find(params[:id]).destroy
    redirect_to welcome_path
  end

end
