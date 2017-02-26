class HangpersonGame

  # add the necessary class methods, attributes, etc. here
  # to make the tests in spec/hangperson_game_spec.rb pass.

  # Get a word from remote "random word" service

  # def initialize()
  # end
  
  def initialize(word)
    @word = word.downcase
    @guesses = ''
    @wrong_guesses = ''
  end
  
  def guess(letter) 
    raise ArgumentError, "invalid guess" unless letter.is_a?(String) && letter.length == 1 && letter.match(/^[[:alpha:]]$/)
    letter = letter.downcase
    if !@guesses.include?(letter) && !@wrong_guesses.include?(letter)
      if @word.include? letter 
        @guesses += letter
      elsif 
        @wrong_guesses += letter
      end
      return true
    end
    return false
  end
  
  def word_with_guesses
    uncovered_word = ""
    @word.each_char do |l|
      if @guesses.include? l 
        uncovered_word += l
      else 
        uncovered_word += "-"
      end
    end
    return uncovered_word
  end

  def check_win_or_lose
      return :win if @word.split("").uniq.length == @guesses.length
      return :lose if @guesses.length + @wrong_guesses.length >= 7
      return :play
  end
    
  def self.get_random_word
    require 'uri'
    require 'net/http'
    uri = URI('http://watchout4snakes.com/wo4snakes/Random/RandomWord')
    Net::HTTP.post_form(uri ,{}).body
  end
  
  
  def word 
    @word
  end
  
  def guesses
    @guesses
  end
  
  def wrong_guesses
    @wrong_guesses
  end

end
