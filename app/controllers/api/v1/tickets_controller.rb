module Api
  module V1
    class TicketsController < ApplicationController
      
      before_filter :restrit_access
      
      respond_to :json
      
      def index
        
        @tickets = Ticket.unactive.all
        
        respond_with(@tickets)
      end
      
      private
      
      def restrit_access
        api_key = ApiKey.find_by_access_token(params[:access_token])
        head :unauthorized unless api_key
      end
      
    end
  end
end