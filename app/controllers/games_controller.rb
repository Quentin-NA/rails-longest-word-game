
require "json"
require "open-uri"

class GamesController < ApplicationController
    
    def new
        @letters = []
        10.times do
          @letters << ('a'..'z').to_a.sample
       end
    end

  def score
    @letters = params[:letters]
    @word = params[:word]
    if english_word?(@word) && included?(@word, @letters)
      @score = @word.length
      @answer = "Congrats! #{@word.upcase} is a valid english word! Your score is: #{@score}"
    else @answer = "Sorry but #{@word.upcase} can't built out of #{@letters.upcase}"
    end
  end   

    private

    def included?(word, letters)
      word.chars.all? { |letter| word.count(letter) <= letters.count(letter) }
    end

    def english_word?(word)
        response = open("https://wagon-dictionary.herokuapp.com/#{word}")
        json = JSON.parse(response.read)
        return json['found']
    end
end
