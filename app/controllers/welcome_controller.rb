class WelcomeController < ApplicationController

  def new
    @user = User.new
    @is_signup = true
  end

  def create
    @user = User.new(params.require(:user).permit(:name, :email, :password, :password_confirmation))
    if @user.save
      # Login user after sign up
      session[:user_id] = @user.id.to_s
      # Create default group
      current_user.groups.create(name: 'Uncategorized', description: 'Room to breathe')
      redirect_to root_path
    else
      redirect_to welcome_path
    end
  end

end
