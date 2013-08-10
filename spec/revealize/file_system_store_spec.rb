require 'spec_helper'
require 'revealize/file_system_store'

module Revealize
  describe FileSystemStore do
    include Files
    after(:each) { rm_r 'spec/fixtures/root' if File.exists? 'spec/fixtures/root' }

    describe "read a slide" do
      let(:deck)  { SlideDeck.new(EmptyTemplate.new) }
      let(:file_system_store) { FileSystemStore.new('spec/fixtures/root', deck) }
      let(:slides) { deck.slides }

      context "when slide does not exist" do
        it "raises an error" do
          expect { file_system_store.read_slide("the_slide") }.to raise_exception(SlideError)
        end
      end

      context "when slide is a haml file" do
        before { a_file('spec/fixtures/root/_slides/the_slide.haml').with_content "%section" }

        it "creates a HamlSlide" do
          file_system_store.read_slide('the_slide')
          slides.should == [HamlSlide.new("%section")]
        end

      end

      context "when slide is a markdown file" do
        before { a_file('spec/fixtures/root/_slides/the_slide.md').with_content "# title" }

        it "creates a MarkdownSlide" do
          file_system_store.read_slide('the_slide')
          slides.should == [MarkdownSlide.new("# title")]
        end
      end

      context "when slide is both a markdown and a haml file" do
        before { a_file('spec/fixtures/root/_slides/the_slide.haml').with_content "%section" }
        before { a_file('spec/fixtures/root/_slides/the_slide.md').with_content "# title" }

        it "prefers the haml one" do
          file_system_store.read_slide('the_slide')
          slides.should == [HamlSlide.new("%section")]
        end
      end
    end
  end
end
