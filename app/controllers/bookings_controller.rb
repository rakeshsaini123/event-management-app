class BookingsController < ApplicationController
    before_action :verify_user, only: [:index, :create, :update, :show, :destroy]

    def index
        @booking = Booking.all
        if @booking.any?
          render json: {data: @booking, message: "Ticket listed successfully"}, status: :ok 
        else
          render json: {data: @booking, message: "No ticket found"}, status: :ok
        end
    end
    
    def show
        @booking = Booking.find_by(id: params[:id])
        if @booking.present?
            render json: {data: @booking, message: "Booking Details found successfully"}, status: :ok 
        else
            render json: {message: "Booking not found"}, status: :ok
        end
    end
    
    def create
        @booking = Booking.new(booking_params)
        if @booking.save
            @customer = User.find_by(id: @booking.customer_id)
            BookingConfirmationJob.perform_async(@customer.id, @booking.id)
            render json: {booking_detail: @booking, message: "Booking done successfully"}, status: :created
        else
            render json: {error: @booking.errors, message: "Something went wrong"}, status: :unprocessable_entity
        end
    end
    
    private
    
    def booking_params
        params.require(:booking).permit(:customer_id, :ticket_id, :ticket_count)
    end

    def verify_user
        role = Role.find_by(name: "Customer")
        user = User.find_by(id: params[:booking][:customer_id], role_id: role.id)
        render json: {errors: 'Unauthorized access'}, status: 401 and return unless user.present?
    end
end
