class RoomsController < ApplicationController
  def index
    @rooms = Room.all.order("created_at DESC")
  end

  def working
    @room = Room.where(:room_label=>"Working").order("created_at DESC")
  end

  def relax
  end

  def show
    @room = Room.find(params[:id])
  end

  def new
    @room = Room.new
  end

  def create
    @room = Room.new(room_params)

    if @room.save
      redirect_to @room, notice: 'Room was successfully saved!'
    else
      render action: 'new'
    end
  end

  def edit
    @room = Room.find(params[:id])
  end

  def update
    @room = Room.find(params[:id])
    if @room.update(room_params)
      redirect_to @room, notice: 'Room was successfully updated.' 
    else
      render action: 'edit' , notice: 'Got some errors'
    end
  end

  def destroy
    @room = Room.find(params[:id])
    @room.destroy
      redirect_to rooms_url
  end

  private

  def room_params
    params.require(:room).permit(:name, :description, :user_id, :room_label)
  end

end