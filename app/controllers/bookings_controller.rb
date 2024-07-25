class BookingsController < ApplicationController
    before_action :set_booking, only: [:show, :edit, :update, :destroy, :check_in, :check_out,:bill]
    before_action :authorize_user, only: [:new, :create]
    before_action :authorize_booking_owner_or_admin, only: [:edit, :update, :destroy]
    before_action :authorize_staff_or_admin, only: [:check_in, :check_out]
  
    def index
      @bookings = current_user.admin? || current_user.staff? ? Booking.all : current_user.bookings
    end
  
    def show
      authorize_view
    end
  
    def new
      @booking = current_user.bookings.new
      @rooms = Room.all
      @room_types = RoomType.all
    end  

    def create
        @booking = current_user.bookings.new(booking_params)
        # @booking.customer=current_user
        if @booking.save
          redirect_to bookings_path, notice: 'Booking was successfully created.'
        elsif @booking.save && current_user.customer?
          redirect_to bill_booking_path 
        else
          render :new
        end
    end
    
    def edit
      @rooms = Room.all
      @room_types = RoomType.all
    end
    
      
    def update
        if @booking.update(booking_params)
          redirect_to bookings_path, notice: 'Booking was successfully updated.'
        else
          render :edit
        end
    end
    
    def destroy
        @booking.destroy
        redirect_to bookings_url, notice: 'Booking was successfully destroyed.'
    end
    
    def check_availability
      @available_rooms = Room.all.select do |room|
        room.bookings.where("check_in < ? AND check_out > ?", params[:check_out], params[:check_in]).empty?
      end
    end
    
    def check_in
      if @booking.update(status: 'checked_in')
        redirect_to bookings_path, notice: 'Guest checked in successfully.'
      else
        redirect_to @booking, alert: 'Failed to check in guest.'
      end
    end
    
    def check_out
      # debugger
      if @booking.update(status: 'checked_out')
        redirect_to bill_booking_path(@booking), notice: 'Guest checked out successfully.'
      else
        redirect_to @booking, alert: 'Failed to check out guest.'
      end
    end


    def invoice 
      @invoice = @booking.invoice
    end 
    
    def update_invoice
      @invoice = Invoice.find(params[:id])
      if @invoice.update(invoice_params) 
        redirect_to @invoice.booking, notice: 'Invoice updated successfully.' 
      else 
        ender :invoice
      end 
    end
    
    def bill
    end
    
    private
    
    def set_booking
        @booking = Booking.find(params[:id])
    end
    
    def authorize_booking_owner_or_admin
        redirect_to bookings_path, alert: 'You are not authorized to perform this action.' unless admin? || @booking.user == current_user
    end
    
    def authorize_staff_or_admin
        redirect_to bookings_path, alert: 'You are not authorized to perform this action.' unless admin? || staff?
    end
    
    def authorize_view
        redirect_to bookings_path, alert: 'You are not authorized to view this booking.' unless admin? || staff? || @booking.user == current_user
    end
    
    def booking_params
        params.require(:booking).permit(:room_id, :check_in, :check_out)
    end

    # def calculate_total_amount(booking)
    #     days = (booking.check_out.to_date - booking.check_in.to_date).to_i
    #     days * booking.room.room_type.rate
    # end

    def authorize_user
      # debugger
      unless current_user.admin? || current_user.customer?
        redirect_to bookings_path, alert: 'You are not authorized to perform this action.'
      end
    end
  
  end
    
    
    
    
    