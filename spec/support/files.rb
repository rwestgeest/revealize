module Files
  include FileUtils
  def a_file(filepath, &block)
    file_writer = FileWriter.new(filepath)
    file_writer.with_content(yield) if block_given?
    file_writer
  end

  def haml_content(content)
    content.gsub(/^ */,'').gsub('.',' ')
  end

  class FileWriter < Struct.new(:filepath)
    include FileUtils
    def with_content(content)
      make_dir
      File.open(filepath, "w+") { |f| f.write(content) }
    end
    def make_dir
      mkdir_p(directory) unless File.exists?(directory)
    end
    def directory
      @directory ||= File.dirname(filepath)
    end
  end

end

