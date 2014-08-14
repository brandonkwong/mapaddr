class UsersController < ApplicationController

  before_action :header, only: [:index, :show, :new, :edit]

  def index
    if current_user
      @groups = current_user.groups.all
      @group = current_user.groups.new
      @locations = @group.locations
      @location = Location.new
      @form_btn = 'Add'
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
    @user = User.new
    @is_signup = true
    @has_navbar = false
  end

  def create
    @user = User.new(user_params)
    if @user.save
      # Login user after sign up
      session[:user_id] = @user.id.to_s
      # Create default group
      current_user.groups.create(name: 'Uncategorized', description: 'Room to breathe')
      redirect_to root_path
    else
      redirect_to :back
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
    reset_session
    User.find(params[:id]).destroy
    redirect_to welcome_path
  end

private

  def user_params
    params.require(:user).permit(:name, :email, :password, :password_confirmation)
  end

end
