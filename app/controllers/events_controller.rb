class EventsController < ApplicationController

  before_action :verify_user, only: [:index, :create, :update, :show, :destroy]

  def index
    @events = Event.all
    if @events.any?
      render json: {data: @events, message: "Event listed successfully"}, status: :ok 
    else
      render json: {data: @events, message: "No event found"}, status: :ok
    end
  end

  def show
    @event = Event.find_by(id: params[:id])
    if @event.present?
      render json: {data: @event, message: "Event found successfully"}, status: :ok 
    else
      render json: {message: "Event not found"}, status: :ok
    end
  end

  def create
    @event = Event.new(event_params)
    if @event.save
      render json: {data: @event, message: "Event created successfully"}, status: :created
    else
      render json: {error: @event.error, message: "Something went wrong"}, status: :unprocessable_entity
    end
  end

  def update
    @event = Event.find_by(id: params[:id])
    if @event.update(event_params)
      render json: {data: @event, message: "Event update successfully"}, status: :ok
    else
      render json: {error: @event.error, message: "Event can not be updated"}, status: :unprocessable_entity
    end
  end

  def destroy
    @event = Event.find_by(id: params[:id])
    if @event.present?
      @event.destroy
      render json: {data: @event, message: "Event deleted successfully"}, status: :ok
    else
      render json: {message: "Event not present"}, status: :ok
    end
  end

  private

  def event_params
    params.require(:event).permit(:name, :date, :venue, :organizer_id)
  end

  def verify_user
    role = Role.find_by(name: "EventOrganizer")
    user = User.find_by(id: params[:event][:organizer_id], role_id: role.id)
    render json: {errors: 'Unauthorized access'}, status: 401 and return unless user.present?
  end
end
