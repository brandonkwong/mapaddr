class GroupsController < ApplicationController

  before_action :header, only: [:index, :create, :edit]
  before_action :render_signup, only: :create

  def create
    @group = current_user.groups.new(group_params)
    if @group.save
      redirect_to root_path
    else
      render 'users/index'
    end
  end

  def edit
    if current_user == Group.find(params[:id]).user
      @group = Group.find(params[:id])
      @form_btn = 'Save Changes'
    else
      redirect_to welcome_path
    end
  end

  def update
    @group = Group.find(params[:id])
    if @group.update_attributes(group_params)
      redirect_to root_path
    else
      render 'edit'
    end
  end

  def destroy
    Group.find(params[:id]).destroy
    redirect_to root_path
  end

private

  def group_params
     params.require(:group).permit(:name, :description, :is_public)
  end

end
