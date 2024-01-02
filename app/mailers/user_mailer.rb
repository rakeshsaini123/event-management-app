class UserMailer < ApplicationMailer

    def booking_confirmation_email
        @user = params[:user]
        @booking = params[:booking]
        mail(to: @user.email, subject: 'Your Booking is confirmed')
    end

    def event_detail_change_email
        @user = params[:user]
        @booking = params[:booking]
        mail(to: @user.email, subject: 'Your Event Booking detail is changed')
    end
end
