class GroupsController < ApplicationController

  # GET
  def index
    @groups = Group.all
    new
  end

  # GET
  def show
    @group = Group.find(params[:id])
  end

  # GET
  def new
    @group = Group.new
  end

  # POST
  def create
    @group = Group.new(params.require(:group).permit(:name, :description))
    if @group.save
      redirect_to groups_path
    else
      render 'new'
    end
  end

  # GET
  def edit
    @group = Group.find(params[:id])
  end

  # PATCH
  def update
    @group = Group.find(params[:id])
    if @group.update_attributes(params.require(:group).permit(:name, :description))
      redirect_to groups_path
    else
      render 'edit'
    end
  end

  # DELETE
  def destroy
    @group = Group.find(params[:id]).destroy
    redirect_to groups_path
  end

end
