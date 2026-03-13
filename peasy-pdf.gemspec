# frozen_string_literal: true

require_relative "lib/peasy_pdf/version"

Gem::Specification.new do |s|
  s.name        = "peasy-pdf"
  s.version     = PeasyPDF::VERSION
  s.summary     = "PDF manipulation — merge, split, compress, rotate, watermark"
  s.description = "PDF manipulation library for Ruby — merge, split, compress, rotate, and watermark PDF files. Wraps system PDF tools (qpdf, poppler-utils) with a clean Ruby API."
  s.authors     = ["PeasyTools"]
  s.email       = ["hello@peasytools.com"]
  s.homepage    = "https://peasypdf.com"
  s.license     = "MIT"
  s.required_ruby_version = ">= 3.0"

  s.files = Dir["lib/**/*.rb"]

  s.metadata = {
    "homepage_uri"      => "https://peasypdf.com",
    "source_code_uri"   => "https://github.com/peasytools/peasy-pdf-rb",
    "changelog_uri"     => "https://github.com/peasytools/peasy-pdf-rb/blob/main/CHANGELOG.md",
    "documentation_uri" => "https://peasypdf.com",
    "bug_tracker_uri"   => "https://github.com/peasytools/peasy-pdf-rb/issues",
  }
end
