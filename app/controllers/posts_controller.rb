class PostsController < ApplicationController
  before_action :authenticate_user! , only: [:new,:create,:edit,:update,:destroy]
  # before_action :find_group_and_check_permission,only:[:edit,:update,:destroy,:join,:quit]

  def destroy

    @group_post.destroy
    flash[:alert] = "删除组"
    redirect_to group_post_path

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
  def new
    @group = Group.find(params[:group_id])
    @post = Post.new
  end

  def create
    @group = Group.find(params[:group_id])
    @post = Post.new(post_params)
    @post.group = @group
    @post.user = current_user

    if @post.save
      redirect_to group_path(@group)
    else
      render :new
    end
  end


  private

  def post_params
    params.require(:post).permit(:content)
  end

end
