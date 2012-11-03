module Api
  module V1
    class TicketsController < ApplicationController
      
      respond_to :json
      
      def index
        
        offset = params[:offset] || 3
        @tickets = Ticket.unactive.order("RAND()").uniq.limit(offset)
        
        respond_with(@tickets)
        
      end
      
    end
  end
end