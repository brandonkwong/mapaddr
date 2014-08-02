class LocationsController < ApplicationController

  # GET
  def index
    @locations = Location.all
  end

  # GET
  def show
    @locations = Location.find(params[:id])
  end

  # POST




end
