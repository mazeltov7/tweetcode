# coding:utf-8

class BeginnerMessageSearchController < ApplicationController
  def index
    @beginner_message_saerches = BeginnerMessage.text_search(params[:query])
  end 
end
