require 'spec_helper'

require 'revealize/slide_deck'

module Revealize
  describe SlideDeck do
    describe "render" do
      let(:slide_deck) { SlideDeck.new(EmptyTemplate.new) }
      let(:mock_renderable1) { double('slide') }
      let(:mock_renderable2) { double('subdeck') }

      before do
        slide_deck.add_slide mock_renderable1
        slide_deck.add_slide mock_renderable2
      end

      it "renders all slides through using template" do
        mock_renderable1.should_receive :render
        mock_renderable2.should_receive :render

        slide_deck.render
      end

      it "returns the rendered result" do
        mock_renderable1.stub(:render).and_return "slide 1"
        mock_renderable2.stub(:render).and_return "slide 2"

        slide_deck.render.should == "slide 1slide 2"
      end
    end
  end
end
