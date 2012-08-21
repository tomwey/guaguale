module Api
  module V1
    class TicketsController < ApplicationController
      
      respond_to :json
      
      def index
        
        @tickets = Ticket.unactive.order("RAND()").uniq.limit(9)
        
        respond_with(@tickets)
        
      end
      
    end
  end
end