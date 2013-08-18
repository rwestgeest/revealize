module Revealize  
  class DeckList
    attr_reader :deck_names
    def initialize(*deck_names)
      @deck_names = deck_names
    end

    def render
      deck_names.map {|deck_name| "<a href=\"/#{deck_name}\">#{deck_name}</a>" }.join($/)
    end
    def ==(other)
      return false unless other.is_a?(DeckList)
      return other.deck_names == deck_names
    end
    def to_s
      "DeckList(#{deck_names.join(', ')})"
    end
  end
end
