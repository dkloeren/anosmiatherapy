class Quote < ApplicationRecord

  def self.quote_of_day
    date = Date.today.to_i
  end
end
