class Admin::UsersController < Admin::BaseController
  before_action :load_user, only: :destroy
  def index
    @users = User.paginate page: params[:page],
      per_page: Settings.user.per_page
  end

  def destroy
    if @user.destroy
      flash[:success] = t "admin.users.destroy.deleted"
    else
      flash[:danger] = t "admin.users.destroy.error"
    end
    redirect_to admin_users_url
  end
  private
  def load_user
    @user = User.find_by id: params[:id]
    unless @user
      flash[:danger] = t "admin.users.destroy.not_found"
      redirect_to :back
    end
  end
end
