class BookingConfirmationJob
    include Sidekiq::Worker
  
    def self.perform(user_id, booking_id)
      user = User.find_by(id: user_id)
      booking = Booking.find_by(id: booking_id)
      UserMailer.with(user: user, booking: booking).booking_confirmation_email.deliver_now
    end
end