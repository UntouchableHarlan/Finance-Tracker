class StocksController < ApplicationController

  def search
    if params[:stock]
      # @tracker = Stock.find_by_ticker(params[:stock])
      @tracker ||= Stock.new_from_lookup(params[:stock])
      respond_to do |format|
        if @tracker
          format.html { render partial: "lookup" }
          format.json { render json: @tracker }
          # @tracker.save
        else
          format.json { render status: :not_found, nothing: true }
        end
      end
    end
  end

end
