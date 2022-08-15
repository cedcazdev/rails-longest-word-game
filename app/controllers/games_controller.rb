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
        if @available_letters.include?(letter.upcase)
          if english_word?(@word) && @available_letters.include?(letter.upcase)
            @answer = "Congratulations! #{@word} is a valid English word!"
            return @answer
          else
            @answer = "Sorry but #{@word.upcase} does not seem to be a valid English word..."
          end
        else
          @answer = "Sorry but #{@word.upcase} can't be built out of #{@available_letters}..."
        end
      end
    else
      @answer = "Sorry it's empty"
    end
  end

  private

  # verificando si la palabra retornado es una palabra ingles incluido en el diccionario de la API
  def english_word?(keyboard)
    # JSON.parse(open("https://wagon-dictionary.herokuapp.com/#{palabra}").read)["found"]

    respuesta = URI.open("https://wagon-dictionary.herokuapp.com/#{keyboard}")
    json = JSON.parse(respuesta.read)
    json['found']
  end
end
