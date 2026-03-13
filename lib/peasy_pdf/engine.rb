# frozen_string_literal: true

require "open3"
require "json"
require "tempfile"

module PeasyPDF
  module_function

  def info(path)
    out, err, status = Open3.capture3("pdfinfo", path.to_s)
    raise Error, "pdfinfo failed: #{err}" unless status.success?
    parse_pdfinfo(out)
  end

  def page_count(path)
    info(path)[:pages]
  end

  def merge(inputs, output: nil)
    output ||= "merged_#{Time.now.to_i}.pdf"
    args = ["qpdf", "--empty", "--pages", *inputs.map(&:to_s), "--", output]
    _out, err, status = Open3.capture3(*args)
    raise Error, "merge failed: #{err}" unless status.success?
    output
  end

  def split(input, output_dir: ".")
    pages = page_count(input)
    results = []
    (1..pages).each do |p|
      out = File.join(output_dir, "page_#{p}.pdf")
      _o, err, st = Open3.capture3("qpdf", input.to_s, "--pages", input.to_s, p.to_s, "--", out)
      raise Error, "split page #{p} failed: #{err}" unless st.success?
      results << out
    end
    results
  end

  def rotate(input, degrees: 90, output: nil)
    output ||= input.to_s.sub(/\.pdf$/i, "_rotated.pdf")
    _o, err, st = Open3.capture3("qpdf", input.to_s, "--rotate=+#{degrees}", "--", output)
    raise Error, "rotate failed: #{err}" unless st.success?
    output
  end

  def compress(input, output: nil)
    output ||= input.to_s.sub(/\.pdf$/i, "_compressed.pdf")
    _o, err, st = Open3.capture3("qpdf", "--linearize", input.to_s, output)
    raise Error, "compress failed: #{err}" unless st.success?
    output
  end

  class Error < StandardError; end

  def parse_pdfinfo(text)
    data = {}
    text.each_line do |line|
      key, val = line.split(":", 2).map(&:strip)
      next unless key && val
      case key
      when "Pages" then data[:pages] = val.to_i
      when "Page size" then data[:page_size] = val
      when "File size" then data[:file_size] = val
      when "Title" then data[:title] = val
      when "Author" then data[:author] = val
      when "Creator" then data[:creator] = val
      when "Producer" then data[:producer] = val
      when "PDF version" then data[:pdf_version] = val
      end
    end
    data
  end
  private_class_method :parse_pdfinfo
end
