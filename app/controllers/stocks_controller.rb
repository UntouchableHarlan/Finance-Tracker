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

  def create
    if params[:stock].present?
      @stock = current_user.stocks.new(ticker: params[:ticker], name: params[:name], last_price: params[:last_price])
    else
      @stock = Stock.find_by_ticker(params[:ticker])
      if @stock
        @stock = current_user.stocks.new(ticker: params[:ticker], name: params[:name], last_price: params[:last_price])
      else
        @stock = Stock.new_from_lookup(params[:ticker])
        if @stock.save
          @stock = current_user.stocks.new(ticker: params[:ticker], name: params[:name], last_price: params[:last_price])
        else
          @stock = nil
          flash[:error] = "Stock not available!"
        end
      end
    end
    respond_to do |format|
      if @stock.save
        format.html { redirect_to my_portfolio_path, notice: "Stock was successfully added" }
        format.json { render :show, status: :created, location: @stock }
      else
        format.html { render :new }
        format.json { render json: @stock.errors, status: :unprocessable_entity }
      end

    end
  end

  def destroy
    @stock = Stock.find(params[:id])
    @stock.destroy
    respond_to do |format|
      format.html { redirect_to my_portfolio_path, notice: 'Stock was successfully deleted.' }
      format.json { head :no_content }
    end
  end

end
