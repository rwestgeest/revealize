require 'spec_helper'
require 'revealize/slide'

module Revealize
  module HamlHelper
    def haml(content)
      Haml::Engine.new(content).render
    end
  end
  describe HamlSlide do
    include HamlHelper
    describe "#render" do
      it "returns the rendered slide" do
        HamlSlide.new("%section(data-transition='fade')").render.should == haml("%section(data-transition='fade')")
      end
    end
  end
  describe MarkdownSlide do
    include HamlHelper
    describe "#render" do
      let(:slide) { MarkdownSlide.new(markdown_content) }
      let(:markdown_content) { "# Cool presentation" }
      subject { slide.render }

      it { should == haml("%section\n  %h1 Cool presentation") }

      context "with an empty preamble" do
        let(:markdown_content) { %Q{---
                                    ---
                                    # Cool presentation}.gsub(/^ */, '') }
        it { should == haml("%section\n  %h1 Cool presentation") }
      end

      context "with a preamble with attributes" do
        let(:markdown_content) { %Q{---
                                    transition : flow
                                    state : blackout
                                    ---
                                    # Cool presentation}.gsub(/^ */, '') }
        it { should == haml("%section(data-state='blackout' data-transition='flow')\n  %h1 Cool presentation") }
      end
    end
  end
end
