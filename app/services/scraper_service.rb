# frozen_string_literal: true

require 'open-uri'

class ScraperService
  GAME_ID = '09' # Lotería Nacional

  def initialize(date)
    @date = date
  end

  def parse
    document.css('.numeroLoteria').first&.text&.to_i
  end

  private

  def document
    Nokogiri::HTML(open("https://www.loteriasyapuestas.es/es/buscador?startDate=#{formatted_date}&gameId=#{GAME_ID}&type=search&endDate=#{formatted_date}"))
  end

  def formatted_date
    @date.strftime('%d/%m/%Y')
  end
end
