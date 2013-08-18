require 'revealize/deck_template'
require 'revealize/slide_deck_dsl'
require 'revealize/slide_deck'
require 'revealize/slide'
require 'revealize/deck_list'

module Revealize
  class SlideError < Exception
    def self.does_no_exist(slide_name)
      self.new("Slide #{slide_name} does not exist")
    end
  end


  class FileSystemStore 
    attr_reader :root_path, :deck

    def initialize(root_path, slide_deck=nil)
      @root_path = root_path
      @deck = slide_deck
    end

    def decks
      DeckList.new *deck_names
    end

    def read_deck(deck_name)
      SlideDeckDsl.new(self).instance_eval(deck_file(deck_name))
      @deck
    end

    def read_layout(layout_name)
      @deck = SlideDeck.new(DeckTemplate.new(layout_file(layout_name)))
    end

    def read_slide(slide_name)
      @deck.add_slide(create_slide(slide_name))
    end

    private

    def deck_file(deck_name)
      File.read(File.join(root_path, '_slide_decks', deck_name + '.deck'))
    end

    def layout_file(layout_name)
      File.read(File.join(root_path, '_layouts', layout_name + '.haml'))
    end

    def deck_names
      Dir[File.join(root_path, '_slide_decks', '*.deck') ].map {|f| File.basename(f,'.deck')}
    end

    def create_slide(slide_name)
      file_name = Dir[File.join(root_path, '_slides', slide_name + '.*')].first
      raise SlideError.does_no_exist(slide_name) unless file_name
      if File.extname(file_name) == '.md'
        MarkdownSlide.new(File.read(file_name))
      else
        HamlSlide.new(File.read(file_name))
      end
    end
  end
end
