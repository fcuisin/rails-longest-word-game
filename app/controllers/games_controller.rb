require "open-uri"

class GamesController < ApplicationController
  VOWELS = %w(A E I O U Y)

  def new
    @letters = generate_grid
  end

  def score
    @word = params[:answer]
    @answer_splitted = params[:letters].split(' ')
    @include = included?(@word, @answer_splitted)
    @en_word = en_word?(@word)

    result
  end

  private

  def generate_grid
    @letters = []
    array = ('A'..'Z').to_a
    5.times do
      @letters << VOWELS.sample
    end
    5.times do
      @letters << (array - VOWELS).sample
    end
    @letters
  end

  def included?(word, grid)
    word.upcase.split('').all? { |letter| grid.include?(letter) }
  end

  def en_word?(word)
    response = open("https://wagon-dictionary.herokuapp.com/#{word.downcase}")
    json = JSON.parse(response.read)
    json['found']
  end

  def result
    if @include == true
      if @en_word == true
        @result = "Yay"
      else
        @result = "Good shot but try again!"
      end
    else
      @result = "Letters out of the grid"
    end
  end
end
