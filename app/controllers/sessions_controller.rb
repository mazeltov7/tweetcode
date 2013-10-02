#coding: utf-8

class SessionsController < ApplicationController
  def callback
    auth = request.env["omniauth.auth"]
    user = User.find_by :provider => auth["provider"], :uid => auth["uid"]

    if user
    
    session[:user_id] = user.id
    redirect_to root_url, :notice => "ログインしました。"
    else
      user = User.create_with_omniauth(auth)
      session[:user_id] = user.id
      redirect_to root_url, :notice => "ログインしました!"
    end


  end

  def destroy
    session[:user_id] = nil
    redirect_to root_url, :notice => "ログアウトしました。"
  end


end
