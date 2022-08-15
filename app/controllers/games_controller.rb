require 'open-uri'
require 'json'

class GamesController < ApplicationController
  def new
    @letters = ('A'..'Z').to_a.sample(10)
  end

  def score
    @word = params[:word]
    @available_letters = params[:available_letters]
    if @word.present?
      @word.split('').each do |letter|
        if @available_letters.include?(letter.upcase) && english_word?(@word)
          @answer = "Congratulations! #{@word.upcase} is a valid English word!"
        elsif !english_word?(@word)
          @answer = "Sorry but #{@word.upcase} does not seem to be a valid English word..."
        else
          @answer = "Sorry but #{@word.upcase} can't be built out of #{@available_letters}..."
        end
      end
    else
      @answer = 'Sorry the entry is empty!!!'
    end
  end

  private

  # verificando si la palabra retornado es una palabra ingles incluido en el diccionario de la API
  # JSON.parse(open("https://wagon-dictionary.herokuapp.com/#{palabra}").read)["found"]
  def english_word?(keyword)
    respuesta = URI.open("https://wagon-dictionary.herokuapp.com/#{keyword}")
    json = JSON.parse(respuesta.read)
    json['found']
  end
end
