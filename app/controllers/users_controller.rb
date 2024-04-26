class UsersController < ApplicationController
  before_action :admin_user

  def new
    @user = User.new
  end

  def index
    @search = User.joins(:attendances).select("users.*, attendances.*").ransack(params[:q])
    @search.sorts = 'id desc' if @search.sorts.empty?
    @users = @search.result.page(params[:page])
  end

  def create
    @user = User.new(user_params)
    if @user.save
      reset_session
      log_in @user
      flash[:success] = "正常に追加されました。"
      redirect_to @user
    else
      render 'new', status: :unprocessable_entity
    end
  end

  def show
    @user = User.find(params[:id])
  end

  def edit
    @user = User.find(params[:id])
  end

  def update
    @user = User.find(params[:id])
    if @user.update(user_params)
      flash[:success] = "正常に更新されました。"
      redirect_to @user
    else
      render 'edit', status: :unprocessable_entity
    end
  end

  def destroy
    @user = User.find(params[:id])
    if @user.destroy
      flash[:success] = "正常に削除しました"
      redirect_to users_path
    else
      redirect_to users_path, :unprocessable_entity
    end
  end

  private
  
    def user_params
      params.require(:user).permit(:name, :employee_number, :password, :password_confirmation)
    end

    #before_action
    def admin_user
      redirect_to(root_url, status: :see_other) unless current_user&.admin?
    end
end
