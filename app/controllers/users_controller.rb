class UsersController < ApplicationController

  def edit
    @user = User.find(params[:id])
  end

  def update
  end

  def destroy
  end

end
