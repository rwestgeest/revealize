require 'revealize/file_system_store'

module Revealize
  class SlideDeck
    def initialize(template)
      @slides = []
      @template = template
    end

    def add_slide(renderable)
      @slides << renderable
    end

    def render
      @template.render(self)
    end

    def slides
      @slides.map { |slide| slide.render }.join()
    end
  end
end

