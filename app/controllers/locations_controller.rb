class LocationsController < ApplicationController

  def index
    @locations = Location.all
  end

  def show
    @location = Location.find(params[:id])
  end
  
  def new
    @location = Location.new
  end

  def create
    @location = Location.new(params.require(:location).permit(:name, :address, :description))
    if @location.save
      redirect_to root_path
    else
      render 'new'  
    end
  end

  def edit
    @location = Location.find(params[:id])
  end

  def update
    @location = Location.find(params[:id])
    if @location.update_attributes(params.require(:location).permit(:name, :address, :description))
      redirect_to root_path
    else
      render 'edit'
    end
  end

  def destroy
    Location.find(params[:id]).destroy
    redirect_to root_path
  end

end
