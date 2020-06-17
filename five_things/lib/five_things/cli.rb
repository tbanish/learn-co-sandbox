class FiveThings::CLI
  
  def call
    FiveThings::Scraper.new.scrape_articles
    greeting
    menu
    article_list
  end
  
  def greeting
    puts <<~MESSAGE
    Welcome to the Five Things app!
    
    Here you can find the top five news stories of the week
    to help you stay informed in a fast efficient way!
    
    MESSAGE
  end
  
  def menu
    puts "Please select an item from the list below (type 'e' to exit):"
    puts ""
    article_list
  end
  
  def article_list
    FiveThings::Article.all.each.with_index(1) do |article, i|
      puts "#{i}. #{article.headline}"
    end
    
    @list_input = gets.strip
    
    if @list_input.downcase == 'e'
      puts "See you next time!"
      exit
    elsif (1..5).include?(@list_input.to_i)
      show_article
    else
      puts "I'm not sure what you meant ..."
      menu
    end
  end

  def input_to_index(input)
    input.to_i - 1
  end
  
  def show_article
    
    article = FiveThings::Article.find_by_index(input_to_index(@list_input))
    puts "#{article.headline}"
    puts ""
    puts "#{article.word_count_message}"
    puts ""
    puts "#{article.body}"
    puts ""
    puts "#{article.source}"
    puts ""
    
    option_message
  end
  
  def option_message
    puts "What would you like to do next?"
    puts "1. See list of articles"
    puts "2. Exit"
    
    @option_input = gets.strip
    
    if @option_input.to_i == 1
      menu
    elsif @option_input.to_i == 2
      puts "Come back again soon!"
      exit
    else
      puts "I'm not quite sure what you mean ..."
      option_message
    end
  end

  
end