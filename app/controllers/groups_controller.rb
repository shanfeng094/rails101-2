class GroupsController < ApplicationController
  before_action :authenticate_user! , only: [:new,:create,:edit,:update,:destroy]
  before_action :find_group_and_check_permission,only:[:edit,:update,:destroy]

  def index
    @groups = Group.all
  end
  def new
    @group = Group.new
  end
  def show
      @group =Group.find(params[:id])
      @posts = @group.posts.order("create_at DESC")
  end
  def destroy

    @group.destroy
    flash[:alert] = "删除组"
    redirect_to groups_path

  end

  def edit


  end
  def update

    if @group.update(group_params)

      redirect_to groups_path,notice:"上传成功！"
    else
      render :edit
    end
  end


  def create
    @group = Group.new(group_params)
    @group.user =current_user
    if @group.save
      redirect_to groups_path
    else
      render :new
    end
  end
  private
  def find_group_and_check_permission
    @group = Group.find(params[:id])

    if current_user != @group.user
      redirect_to root_path, alert: "You have no permission."
    end
  end

  def group_params
    params.require(:group).permit(:title, :description)
  end
end
