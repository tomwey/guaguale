
class FilesController < ApplicationController
  def show
    @ticket = Ticket.find(params[:id])
    send_file @ticket.avatar.path(params[:style]), :filename => @ticket.avatar.asset_file_name,
                                   :content_type => @ticket.avatar.asset_content_type
  end
end
