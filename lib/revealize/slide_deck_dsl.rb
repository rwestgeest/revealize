module Revealize
  class SlideDeckDsl < Struct.new(:deck_store)
    def layout(layout_name)
      deck_store.read_layout(layout_name)
    end
    def slide(slide_name)
      deck_store.read_slide(slide_name)
    end
  end
end

