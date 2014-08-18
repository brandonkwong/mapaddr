class LocationsController < ApplicationController

  before_action :header, only: [:edit, :create]
  before_action :render_signup, only: :create

  def create
    # Attach group id to new location
    @group = Group.find(params[:group_id])
    @location = current_user.locations.new(location_params)
    @location.group = @group
    if @location.save
      redirect_to root_path
    else
      render 'users/index'
    end
  end

  def edit
    if current_user == Location.find(params[:id]).group.user
      @location = Location.find(params[:id])
      @group_options = current_user.groups.all.sort_by{ |alpha| alpha.name.downcase }.map{ |g| [ g.name, g.id ] }
      @form_btn = 'Save Changes'
    else
      redirect_to welcome_path
    end
  end

  def update
    @location = Location.find(params[:id])
    if @location.update_attributes(location_params)
      redirect_to root_path
    else
      # render 'edit'
    end
  end

  def destroy
    Location.find(params[:id]).destroy
    redirect_to root_path
  end

private

  def location_params
    params.require(:location).permit(:name, :address, :description, :group_id)
  end

end
