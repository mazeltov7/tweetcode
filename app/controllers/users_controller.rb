class UsersController < ApplicationController

  def show
    @user = User.find(params[:id])
  end

  def edit
    @user = User.find(params[:id])
  end

  def update
    @user = User.find(params[:id])

    respond_to do |format|
      if @user.update(user_params)
        BeginnerMessage.create(body: 'hello world', user: current_user)
        format.html { redirect_to root_url, notice: 'User was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: 'edit' }
        format.json { render json: @user.errors, status: :unprocessable_entity }
      end
    end    
  end

  def destroy
  end

  private
  def user_params
    params.require(:user).permit(:username, :status, :profile)
  end


end