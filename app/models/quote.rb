class Quote < ApplicationRecord
  # Cycle through a new quote each day
  def self.quote_of_day
    quotes = self.all
    index = (Date.today - Date.new).to_i % quotes.length
    quotes[index]
  end
end
