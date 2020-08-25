class UsersController < ApplicationController

def new
  @user = User.new
end

def show
  redirect_to root_path
end

  def destroy
    @user = User.find(params[:id])
    @user.destroy
    redirect_to new_user_session_path
 end

 private

 def user_params
    params.require(:user).permit(:name, :email)
  end

end
