class BeginnerMessagesController < ApplicationController
  before_filter :authenticate_user!
  
end