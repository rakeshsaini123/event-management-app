class TicketsController < ApplicationController
  before_action :verify_user, only: [:index, :create, :update, :show, :destroy]

  def index
    @tickets = Ticket.all
    if @tickets.any?
      render json: {data: @tickets, message: "Ticket listed successfully"}, status: :ok 
    else
      render json: {data: @tickets, message: "No ticket found"}, status: :ok
    end
  end

  def show
    @ticket = Ticket.find_by(id: params[:id])
    if @ticket.present?
      render json: {data: @ticket, message: "Ticket found successfully"}, status: :ok 
    else
      render json: {message: "Ticket not found"}, status: :ok
    end
  end

  def create
    @ticket = Ticket.new(ticket_params)
    if @ticket.save
      render json: {data: @ticket, message: "Ticket created successfully"}, status: :created
    else
      render json: {error: @ticket.errors, message: "Something went wrong"}, status: :unprocessable_entity
    end
  end

  def update
    @ticket = Ticket.find_by(id: params[:id])
    if @ticket.update(ticket_params)
      render json: {data: @ticket, message: "Ticket update successfully"}, status: :ok
    else
      render json: {error: @ticket.error, message: "Ticket can not be updated"}, status: :unprocessable_entity
    end
  end

  def destroy
    @ticket = Ticket.find_by(id: params[:id])
    if @ticket.present?
      @ticket.destroy
      render json: {data: @ticket, message: "Ticket deleted successfully"}, status: :ok
    else
      render json: {message: "Ticket not present"}, status: :ok
    end
  end

  private

  def ticket_params
    params.require(:ticket).permit(:ticket_type, :price, :availability, :event_id)
  end

  def verify_user
    role = Role.find_by(name: "EventOrganizer")
    event = Event.find_by(id: params[:ticket][:event_id])
    user = User.find_by(id: event&.organizer_id, role_id: role.id)
    render json: {errors: 'Unauthorized access'}, status: 401 and return unless user.present?
  end
end
