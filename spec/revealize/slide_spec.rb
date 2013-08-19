require 'spec_helper'
require 'revealize/slide'

module Revealize
  module HamlHelper
    def haml(content)
      Haml::Engine.new(content.gsub(/^ */, '').gsub('.', ' ')).render
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
      let(:slide) { MarkdownSlide.new(markdown_content.gsub(/^ */, '') ) }
      let(:markdown_content) { "# Cool presentation" }
      subject { slide.render }

      context "containing a single slide" do
        it { should == haml("%section\n..%h1 Cool presentation") }

        context "with an empty preamble" do
          let(:markdown_content) { %Q{---
                                    ---
                                    # Cool presentation}}
                                   it { should == haml("%section\n..%h1 Cool presentation") }
        end

        context "with a preamble with attributes" do
          let(:markdown_content) { %Q{---
                                    transition : flow
                                    state : blackout
                                    ---
                                    # Cool presentation} }
                                   it { should == haml("%section(data-state='blackout' data-transition='flow')\n..%h1 Cool presentation") }
        end
      end

      context "containing multiple slides" do
        let(:markdown_content) { %Q{# slide one



                                    # slide two} }
        it { should == haml(%Q{%section
                               ..%h1 slide one
                               %section
                               ..%h1 slide two}) }
      end

      context "containing nested slides", :broken => true do
        let(:markdown_content) { %Q{# slide one


                                    # slide two} }
        it { should == haml(%Q{%section
                               ..%section
                               ....%h1 slide one
                               ..%section
                               ....%h1 slide two}) }
      end
    end
  end
end
