class Booking < ApplicationRecord
    belongs_to :user
    belongs_to :room
    has_one :invoice
    has_many :room_types, through: :rooms

    validates :check_in, presence:true
    validates :check_out, presence:true
    validate :check_out_after_check_in
    before_create :room_availability

    after_create :create_invoice

    # def self.avilable_rooms(start_date,end_date)
    #     booked_rooms = Booking.where("check_in < ? And check_out > ?",end_date,start_date).pluck(:room_id)
    #     Room.where.not(id:booking_rooms)
    # end

    def duration
        (check_out - check_in).to_i
    end
    
    def total_cost
        duration * room.room_type.rate
    end
    

    private
    def check_out_after_check_in
        if check_in && check_out && check_out <= check_in
            errors.add(:check_out,"must be after check-in date")
        end
    end

    def room_availability
        if check_in && check_out
            overlapping_bookings = Booking.where(room_id: room_id).where.not(id: id)
                                           .where("check_in < ? AND check_out > ?",check_out,check_in)
            if overlapping_bookings.exists?
                errors.add(:room_id,"is not available for selected dates")
            end
        end
    end

    def create_invoice
        Invoice.create( total_amount: total_cost, status: 'unpaid', issued_at: Time.current)
    end
       
end