class DocumentsController < ApplicationController

  def show
    begin
      item = Item.find(params[:id])
      disposition = ['inline', 'attachment'].include?(params[:disposition]) ? params[:disposition] : :attachment
      content = open(item.document.service.send(:object_for, item.document.key).public_url).read
      send_data content, filename: item.document.filename.to_s, disposition: disposition
    rescue => e
      redirect_to :back
    end
  end

end
