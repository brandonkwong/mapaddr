class GroupsController < ApplicationController

  def index
    @groups = Group.all
    new

    @locations = Location.all
  end

  def new
    @group = Group.new
  end

  def create
    @group = Group.new(params.require(:group).permit(:name, :description))
    if @group.save
      redirect_to root_path
    else
      render 'new'
    end
  end

  def edit
    @group = Group.find(params[:id])
  end

  def update
    @group = Group.find(params[:id])
    if @group.update_attributes(params.require(:group).permit(:name, :description))
      redirect_to root_path
    else
      render 'edit'
    end
  end

  def destroy
    @group = Group.find(params[:id]).destroy
    redirect_to root_path
  end

end
