require 'tempfile'
require_relative 'structure_of_pragmatic_programming'

class Epub

  def create
    unless `which pandoc`.length > 0
      puts "Pandoc needs to be installed to generate the ePub"
      return
    end

    markdown_files = MARKDOWN_FILES
    all_markdown = get_markdown_files
    diff = (markdown_files|all_markdown) - (markdown_files & all_markdown)
    if diff.length > 0
      puts "Looks like #{diff.join(", ")} is/are missing."
    end

    `pandoc -f markdown -t epub --epub-cover-image=assets/Cover.png -o pragmatic_testing.epub --smart --toc --epub-stylesheet=assets/pragmatic_style.css #{ markdown_files.join(" " )}`
  end

  def get_markdown_files
    mdfiles = []
    Dir.foreach('./chapters') do |item|
      next if item == '.' or item == '..'
      next if item[-2..-1] != "md"
      next if item == "README.md"

      mdfiles << "chapters/" + item
    end
    mdfiles
  end

end
