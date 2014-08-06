class LocationsController < ApplicationController

  def create
    @group = Group.find(params[:group_id])
    location = Location.new(params.require(:location).permit(:name, :address, :description))
    location.group = @group
    if location.save
      redirect_to root_path
    else
      # render 'new'
    end
  end

  def edit
    @group = Group.find(params[:group_id])
    @location = Location.find(params[:id])
  end

  def update
    @group = Group.find(params[:group_id])
    @location = Location.find(params[:id])
    if @location.update_attributes(params.require(:location).permit(:name, :address, :description))
      redirect_to root_path
    else
      # render 'edit'
    end
  end

  def destroy
    @group = Group.find(params[:group_id])
    Location.find(params[:id]).destroy
    redirect_to root_path
  end

end
