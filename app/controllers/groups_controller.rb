class GroupsController < ApplicationController

  # GET
  def index
    @groups = Group.all
    # @groups = Group.new
  end

  # GET
  def show
    @groups = Group.find(params[:id])
  end

  # GET
  def new
    @groups = Group.new
  end

  # POST



end
