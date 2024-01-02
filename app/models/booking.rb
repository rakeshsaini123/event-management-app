class Booking < ApplicationRecord
  belongs_to :customer, class_name: "User"
  belongs_to :ticket

  before_save :calculate_total_amount

  private

  def calculate_total_amount
    ticket_price = Ticket.find_by(id: self.ticket_id)&.price
    self.final_amount = ticket_price * self.ticket_count
  end
end
