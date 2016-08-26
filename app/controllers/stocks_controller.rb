class StocksController < ApplicationController

  def search
    if params[:stock]
      @tracker = Stock.find_by_ticker(params[:stock])
      @tracker ||= Stock.new_from_lookup(params[:stock])
      if @tracker
        render partial: lookup
        render json: @tracker
      else
        render status: :not_found, nothing: true
      end
    end
  end
end
