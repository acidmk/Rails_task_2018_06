class TagsController < ApplicationController
  def index
    json = [].to_json
    if params[:name]
      @tags = Tag.where({:name => /#{params[:name]}/})
      json = @tags.to_json
    end

    respond_to do |format|
      format.json do
        render json: json
      end
    end
  end
end
