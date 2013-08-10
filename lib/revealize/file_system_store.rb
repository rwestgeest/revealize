require 'revealize/deck_template'
require 'revealize/slide_deck_dsl'
require 'revealize/slide_deck'
require 'revealize/slide'

module Revealize
  class FileSystemStore < Struct.new(:root_path)

    def read_deck(deck_name)
      SlideDeckDsl.new(self).instance_eval(deck_file(deck_name))
      @deck
    end

    def read_layout(layout_name)
      @deck = SlideDeck.new(DeckTemplate.new(layout_file(layout_name)))
    end

    def read_slide(slide_name)
      @deck.add_slide(Slide.new(slide_file(slide_name)))
    end

    private

    def deck_file(deck_name)
      File.read(File.join(root_path, 'slide_decks', deck_name + '.deck'))
    end

    def layout_file(layout_name)
      File.read(File.join(root_path, 'layouts', layout_name + '.haml'))
    end

    def slide_file(slide_name)
      File.read(File.join(root_path, 'slides', slide_name + '.haml'))
    end
  end
end
