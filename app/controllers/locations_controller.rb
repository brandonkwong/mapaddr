class LocationsController < ApplicationController

  before_action :header, only: :edit

  def create
    @group = Group.find(params[:group_id])
    location = current_user.locations.new(params.require(:location).permit(:name, :address, :description))
    location.group = @group
    if location.save
      redirect_to root_path
    else
      # render 'new'
    end
  end

  def edit
    if current_user == Location.find(params[:id]).group.user
      @location = Location.find(params[:id])
      @group_options = current_user.groups.all.sort_by{ |alpha| alpha.name.downcase }.map{ |g| [ g.name, g.id ] }
    else
      redirect_to welcome_path
    end
  end

  def update
    @location = Location.find(params[:id])
    if @location.update_attributes(params.require(:location).permit(:name, :address, :description, :group_id))
      redirect_to root_path
    else
      # render 'edit'
    end
  end

  def destroy
    Location.find(params[:id]).destroy
    redirect_to root_path
  end

  def header
    @has_navbar = true
    @user_login = User.new
    @is_login = true
  end

end
