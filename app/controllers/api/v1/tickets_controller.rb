module Api
  module V1
    class TicketsController < ApplicationController
      
      http_basic_authenticate_with :name => "keke", :password => "keke-guagua"
      
      respond_to :json
      
      def index
        
        @tickets = Ticket.unactive.order("RANDOM()").uniq.limit(9)
        
        respond_with(@tickets)
      end
      
    end
  end
end