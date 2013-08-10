require 'haml'
module Revealize
  class Server < Sinatra::Base
    get '/:slide_deck' do
      deck params[:slide_deck]
    end

    def slide(slide)
      hamelize(haml_section(slide, read(slide_path(slide))))
    end

    def deck(slide_deck)
      hamelize(read(deck_path(slide_deck)))
    end

    def hamelize(text)
      Haml::Engine.new(text).render(self)
    end
  
    def read(filepath)
      File.read(filepath)
    end
    def deck_path(slide_deck)
      "slide_decks/#{slide_deck}.haml"
    end
    def slide_path(slide)
      "slides/#{slide}.haml"
    end

    def haml_section(section_id, text)
      "%section##{section_id}\n#{text.gsub(/^/, '  ')}"
    end

  end
end
