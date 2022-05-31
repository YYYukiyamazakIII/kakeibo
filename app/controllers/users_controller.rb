class UsersController < ApplicationController

  def show
    @user = User.find(params[:id])
    if @user.id != current_user.id
      redirect_to root_path
    end
  end

  private
  def user_params
    params.require(:user).permit(:name, :email, :password, :prefecture_id, :city, :profile)
  end

end
