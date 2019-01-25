class User < ActiveRecord::Base
  has_many :user_quotes
  has_many :quotes, through: :user_quotes

  def say_quote
    self.quotes.map do |quote|
      quote.content
    end.uniq
  end


  def happy_days
    happy_quotes = self.quotes.select do |quote|
      quote.mood == "happy"
    end
     puts "Your total moments of happiness have been #{happy_quotes.count}! Be grateful for the little things."
     puts "\u{1f600}"
  end

  def sad_days
    sad_quotes = self.quotes.select do |quote|
      quote.mood == "sad"
    end
    puts "Your total moments of sadness have been #{sad_quotes.count}. Remember, everybody hurts sometimes."
    puts "\u{1f496}"
  end

  def anxious_days
    anxious_quotes = self.quotes.select do |quote|
      quote.mood == "anxious"
    end
    puts "Your total moments of anxiety have been #{anxious_quotes.count}. Breathe and be kind to yourself."
    puts "\u{1f308}"
  end


#   def delete_all_quote
#     self.quotes.map do |quote|
#       quote.last
#   end
# end
end
