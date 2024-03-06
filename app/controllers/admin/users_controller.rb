class Admin::UsersController < UsersController
  before_action :sign_in_required
  before_action :admin_required
  skip_before_action :sign_out_required, only: [:new, :create]
  skip_before_action :correct_user, only: [:create, :show, :update]

  def index
    @users = User.with_tasks_amount
  end

  def create
    @user = User.new(user_params)
      if @user.save
        redirect_to admin_users_path, notice: t('.created')
      else
        render :new
      end
  end

  def update
      if @user.update(user_params)
        redirect_to admin_users_path, notice: t('.updated')
      else
        flash[:notice] = t('.no_admin')
        render :edit
      end
  end

  def destroy
      if @user.destroy
        redirect_to admin_users_path, notice: t('.destroyed')
      else
        @users = User.with_tasks_amount
        flash[:notice] = t('.no_admin')
        render :index
      end
  end

  private

  def set_user
    @user = User.find(params[:id])
  end

  def user_params
    params.require(:user).permit(:name, :email, :password, :password_confirmation, :admin)
  end

  def correct_user
    @user = User.find(params[:id])
    redirect_to tasks_path, notice: t('notice.reject') unless current_user?(@user)
  end

  def admin_required
    redirect_to tasks_path, notice: t('notice.require_admin') unless current_user.admin
  end
end
