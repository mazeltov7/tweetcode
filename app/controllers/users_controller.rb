class UsersController < ApplicationController

  def show
    @user = User.find(params[:id])
  end

  def edit
    @user = User.find(params[:id])
  end

  def update
    @user = User.find(params[:id])
      if @user.update(user_params)
          Message.create(body: 'Hello World', user: current_user, room_id: '1')
        redirect_to room_messages_path(1)
      else
        render action: 'edit' , notice: 'Got some errors'
      end
  end

  def destroy
  end

  private
  def user_params
    params.require(:user).permit(:username, :status, :profile)
  end

end
