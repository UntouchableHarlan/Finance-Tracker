class Stock < ApplicationRecord
  scope :by_ticker, -> (ticker_symbol) { where(ticker: ticker_symbol) }

  def self.new_from_lookup(ticker_symbol)
    look_up = StockQuote::Stock.quote(ticker_symbol)
    return nil unless look_up.name

    new_stock = Stock.new(ticker: look_up.symbol, name: look_up.name)
    new_stock.last_price = new_stock.price
    new_stock
  end

  # def self.find_by_ticker(ticker_symbol)
  #   where(ticker: ticker_symbol)
  # end

  def price
    closing_price = StockQuote::Stock.quote(ticker).close
    return "#{closing_price}" if closing_price

    opening_price = StockQuote::Stock.quote(ticker).open
    return "#{opening_price}" if opening_price

    'Unavailable'
  end
end
