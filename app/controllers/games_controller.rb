class GamesController < ApplicationController
  def new
    @letters = generate_grid
  end

  def score
    @word = params[:answer]
    @answer_splitted = params[:letters].split(' ')
    @result = included?(@word, @answer_splitted)
  end

  private

  def generate_grid
    @letters = []
    array = ('A'..'Z').to_a
    10.times do
      @letters << array.sample
    end
    @letters
  end

  def included?(word, grid)
    word.split('').all? { |letter| grid.include? letter }
  end
end
