class UsersController < ApplicationController

  before_action :header, except: [:update, :destroy]

  def index
    if current_user
      @groups = current_user.groups.all
      @group = current_user.groups.new
      @locations = @group.locations
      @location = Location.new
      @form_btn = 'Add'
      # render_location
    else
      redirect_to welcome_path
    end
  end

  def show
    # Alternative: @user = User.find_by(username: params[:id])
    @user = User.find(params[:id])
    @groups = @user.groups.all
  end

  def new
    @has_navbar = false
    @user = User.new
    @is_signup = true
  end

  def create
    # Variable for processing signup errors in render new
    @has_navbar = false
    @user = User.new(user_params)
    if @user.save
      # Login user after signup
      session[:user_id] = @user.id.to_s
      # Create default uncategorized group on signup
      current_user.groups.create(name: 'Uncategorized', description: 'Room to breathe')
      redirect_to root_path
    else
      render 'new'
    end
  end

  def edit
    if current_user == User.find(params[:id])
      @user = current_user
    else
      redirect_to welcome_path
    end
  end

  def update
    @user = User.find(params[:id])
    if @user.update_attributes(user_params)
      redirect_to root_path
    else
      render 'edit'
    end
  end

  def destroy
    # Logout user before deleting account
    reset_session
    User.find(params[:id]).destroy
    redirect_to welcome_path
  end

private

  def user_params
    params.require(:user).permit(:name, :email, :password, :password_confirmation)
  end

end
