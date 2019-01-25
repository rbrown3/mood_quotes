require 'pry'
require 'audite'

ActiveRecord::Base.logger = nil
 ActiveSupport::Deprecation.silenced = true

 def music
   player = Audite.new
   player.load('./lib/openingsong.mp3')
   player.start_stream
 end

# use TTY prompt globally
$prompt = TTY::Prompt.new(active_color: :magenta)

def clear_screen
  system "clear"
end

def start_program
  # @variable is used for class variables
  music
  font = TTY::Font.new(:starwars)
  pastel = Pastel.new
  puts pastel.bright_magenta(font.write("Mood Quotes",letter_spacing:2))

  sleep(3)

  clear_screen

  @name = $prompt.ask('What is your name?')

   # check_name = User.all.include? (@name)
   #  if check_name == true
   #  puts "Sorry, name is taken."
   #  @name = $prompt.ask('What is your name?')

  #end
#   do |q|
#   question.validate(/\A\w+@\w+\.\w+\Z/)
#   question.messages[:required?] = 'Name required'
# end #, default: ENV['USER'])
  password = $prompt.mask("What is your password?")

  @current_user = User.find_or_create_by(name: @name)


  feeling_question
end





def feeling_question
  clear_screen
  feeling = $prompt.select("How are you feeling, #{@name}?") do |menu|
    menu.choice "Happy" => -> do happy end
    menu.choice "Sad" => -> do sad end
    menu.choice "Anxious" => -> do anxious end
    menu.choice "exit" => -> do exit_app end

  end
end


  # choices = %w(sad happy anxious)
  # prompt.multi_select("How are you feeling?", choices)
  # if choices == sad
  #
  # elsif choices == happy
  #
  # else
  #
  # end



def options
  your_options = $prompt.select("What do you want to do now?") do |menu|
    menu.choice "GO back and select new feeling" => -> do feeling_question end
    menu.choice "See my quotes" => -> do print_quotes(@current_user)end
    menu.choice "happy days" => -> do all_happy_days(@current_user) end
    menu.choice "sad days" => -> do all_sad_days(@current_user) end
    menu.choice "anxious days" => -> do all_anxious_days(@current_user) end
    menu.choice "mood_tracker" => -> do mood_tracker(@current_user) end
    menu.choice "Resources for your mental and emotional health" => -> do resources end
    menu.choice "change username" => -> do change_username end
    menu.choice "Delete my account" => -> do delete_user end
    menu.choice "exit" => -> do exit_app end
    end
end

def exit_app
  return
end

def print_quotes(user)

  array_of_quotes = user.say_quote
  array_of_quotes.each_with_index do |quote, i|
    puts "#{i+1}. #{quote}\n"
    puts "\n"
  end
    sleep(7)
    clear_screen
  options
end

def all_happy_days(user)
  user.happy_days
  options
end



def all_sad_days(user)
  user.sad_days
  options
end

def all_anxious_days(user)
  user.anxious_days
  options
end

def mood_tracker(user)
  clear_screen
  my_moods = []
  my_moods << user.happy_days
  my_moods << user.sad_days
  my_moods << user.anxious_days
  my_moods
  options
end

#def total_moments

def change_username
user = User.find_by(name:@name)
user.name =$prompt.ask('What is your name?')
user.save
options
end

  def delete_user
     user = User.find_by(name: @name)
     puts "Sad to see you go, but we understand! You are loved and the world needs someone like you!\u{1f496} "
     user.destroy
  end
# def delete_last_entry(user)
#   array = print_quotes(user)
#   array.pop
#   array
# end

# def delete_user
#   user = User.find_by(name: @name)
#   erase_account = user.destroy
#   erase_account
# end

def happy
  puts "You are happy! All of our emotions are normal, accept them, but understand that you have an essence at your core that is unshakeable and unbreakable."
  sleep(2)
  happy_quotes = Quote.all.select do |quote|
    quote.mood == "happy"
  end



  number_happy_quotes = happy_quotes.size
  selected_happy_quote = happy_quotes[rand(1..number_happy_quotes)]
  puts "#{selected_happy_quote.content} author: #{selected_happy_quote.author}"
  UserQuote.create(user_id: @current_user.id, quote_id: selected_happy_quote.id)
  puts "                                                             "
  sleep(7)
  clear_screen
  options

  # $prompt.select("What do you want to do now?") do |menu|
  #   menu.choice "GO back and select new feeling" => -> do feeling_question end
  end

def sad
  puts "You are sad! All of our emotions are normal, accept them, but understand that you have an essence at your core that is unshakeable and unbreakable."

  sad_quotes = Quote.all.select do |quote|
  sad_result= quote.mood == "sad"
  end

  number_sad_quotes = sad_quotes.size
  selected_sad_quote = sad_quotes[rand(1..number_sad_quotes)]
  puts "#{selected_sad_quote.content} author: #{selected_sad_quote.author}"
  UserQuote.create(user_id: @current_user.id, quote_id: selected_sad_quote.id)
  sleep(7)
  clear_screen
  options

  # $prompt.select("What do you want to do now?") do |menu|
  #   menu.choice "GO back and select new feeling" => -> do feeling_question end
  # #have a choice to save quote to userquote and retrieve later

  end


def anxious
  puts "You're anxious! All of our emotions are normal, accept them, but understand that you have an essence at your core that is unshakeable and unbreakable."


  anxious_quotes = Quote.all.select do |quote|
    anxious_result = quote.mood == "anxious"
  end

  number_anxious_quotes = anxious_quotes.size
  selected_anxious_quote = anxious_quotes[rand(1..number_anxious_quotes)]

  puts "#{selected_anxious_quote.content} author: #{selected_anxious_quote.author}"
  UserQuote.create(user_id: @current_user.id, quote_id: selected_anxious_quote.id)
  sleep(7)
  clear_screen
  options
  end

  def resources
    clear_screen
    puts "If you are in an emotionally or physically abusive relationship, remember it isn't your fault and you deserve the help that you need. Safe Horizon Hotline : 800-621-HOPE (4673)\u{1f496}"
    puts "We can all prevent suicide. If you or someone you know is in crisis, call The National Suicide Prevention Hotline: 1-800-273-8255. You are not alone \u{1f496}. "
    puts "Service for LGBT and questioning people. Call the LGBT National Help Center: 1-888-843-4564 \u{1f496} ."
    options
   end
  # def run
  # @current_user = start_program
  # options
  # end




  # $prompt.select("What do you want to do now?") do |menu|
  #   menu.choice "GO back and select new feeling" => -> do feeling_question end
  # #have a choice to save quote to userquote and retrieve later
  # end
