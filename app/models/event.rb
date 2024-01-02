class Event < ApplicationRecord
    belongs_to :organizer, class_name: "User"
    has_many :tickets

    before_update :send_event_update_email

    private

    def send_event_update_email
      if self.date_changed? || self.venue_changed? || self.name_changed?
        bookings = Booking.all
        bookings.each do |booking|
          EventDetailChangeJob.perform_async(booking.customer.id, booking.id)
        end
      end
    end
end
