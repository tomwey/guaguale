module Api
  module V1
    class TicketsController < ApplicationController
      
      respond_to :json
      
      def index
        respond_with Ticket.all.limit(9).shuffle
      end
      
    end
  end
end