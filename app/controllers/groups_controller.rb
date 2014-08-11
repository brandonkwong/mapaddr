class GroupsController < ApplicationController

  before_action :header, only: [:index, :edit]

  # Testing: delete afterwards
  def index
    @groups = Group.all
    @group = Group.new
    @locations = @group.locations
    @location = Location.new
  end

  def create
    @group = current_user.groups.new(params.require(:group).permit(:name, :description))
    if @group.save
      redirect_to root_path
    else
      # render 'new' does not exist / replace with error message
    end
  end

  def edit
    if current_user && current_user.id == Group.find(params[:id]).user_id
      @group = Group.find(params[:id])
    else
      redirect_to welcome_path
    end
  end

  def update
    @group = Group.find(params[:id])
    if @group.update_attributes(params.require(:group).permit(:name, :description, :is_public))
      redirect_to root_path
    else
      render 'edit'
    end
  end

  def destroy
    Group.find(params[:id]).destroy
    redirect_to root_path
  end

  def header
    @has_navbar = true
    @user_login = User.new
    @is_login = true
  end

end
