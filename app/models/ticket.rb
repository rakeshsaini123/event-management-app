class Ticket < ApplicationRecord
  belongs_to :event
  has_many :bookings

  validates :ticket_type, presence: true

  enum ticket_type: { "General Admission": 0, "VIP": 1, "Platinum": 2 }
end
