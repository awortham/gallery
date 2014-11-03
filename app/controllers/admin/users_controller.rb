class Admin::UsersController < Admin::AdminController

  def index
    @users = User.all
  end

  def show
    @user = User.find(params[:id])
  end

  def edit
    @user = User.find(params[:id])
  end

  def update
    user = User.find(params[:id])
    if user.update(user_params)
      gflash :now, :success => "Account for #{user.name.capitalize} Updated"
    else
      gflash :now, :error => user.errors.full_messages.to_sentence
    end
    redirect_to admin_user_path(business.slug, user)
  end

  def destroy
    user = User.find(params[:id])

    if user.destroy
      gflash :now, :notice => "Successfully Deleted #{user.name.capitalize}"
      redirect_to admin_path(business.slug)
    else
      gflash :now, :error => user.errors.full_messages.to_sentence
      redirect_to admin_show_user_path(business.slug, user)
    end
  end

  private
  def user_params
    params.require(:user).permit(:name, :password, :password_confirmation, :admin)
  end

end
