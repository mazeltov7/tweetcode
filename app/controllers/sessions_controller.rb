#coding: utf-8

class SessionsController < ApplicationController
  def callback
    auth = request.env["omniauth.auth"]
    user = User.find_by :provider => auth["provider"], :uid => auth["uid"] || User.create_withomniauth(auth)
    session[:user_id] = user.id
    redirect_to root_url, :notice => "ログインしました。"
  end

  def destroy
    session[:user_id] = nil
    redirect_to root_url, :notice => "ログアウトしました。"
  end


end
