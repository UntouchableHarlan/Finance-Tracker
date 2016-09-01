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

  def not_friends_with(friend_id)
    friendships.where(friend_id: friend_id).count < 1
  end

  def execpt_current_user(user)
    user.reject { |u|  u.id == self.id }
  end

  def self.search(param)
    return User.none if param.blank?

    param.strip!
    param.downcase!
    (name_matches(param) + email_matches(param))
  end

  def self.name_matches(param)
    matches('name', param)
  end

  def self.email_matches(param)
    matches('email', param)
  end

  def self.matches(field_name, param)
    where("lower(#{field_name}) like ?", "%#{param}%")
  end

end
