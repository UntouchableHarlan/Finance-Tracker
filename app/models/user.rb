class User < ApplicationRecord
  has_secure_password
  has_many :stocks
  has_many :friendships
  has_many :friends, through: :friendships

  def can_add?(ticker)
    under_stock_limit? && !stock_already_added?(ticker)
  end

  def under_stock_limit?
    if self.stocks.count > 6
      return false
    else
      return true
    end
  end

  def stock_already_added?(ticker)
    if self.stocks.where(ticker: ticker).exists?
      return true
    else
      return false
    end
  end

end
