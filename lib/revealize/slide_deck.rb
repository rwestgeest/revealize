require 'revealize/file_system_store'

module Revealize
  class SlideDeck
    attr_reader :slides
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

    def render_slides
      @slides.map { |slide| slide.render }.join()
    end
  end
end

