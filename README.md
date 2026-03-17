# peasy-pdf

[![Gem Version](https://badge.fury.io/rb/peasy-pdf.svg)](https://rubygems.org/gems/peasy-pdf)
[![License: MIT](https://img.shields.io/badge/License-MIT-blue.svg)](https://opensource.org/licenses/MIT)

Ruby client for the [PeasyPDF](https://peasypdf.com) API — merge, split, compress, rotate, and watermark PDF files. Zero dependencies beyond Ruby stdlib (Net::HTTP, JSON, URI).

Built from [PeasyPDF](https://peasypdf.com), a free online PDF toolkit with tools for every PDF workflow — merge multiple documents, split pages, compress file size, rotate orientations, and add watermarks.

> **Try the interactive tools at [peasypdf.com](https://peasypdf.com)** — [PDF Tools](https://peasypdf.com/), [PDF Glossary](https://peasypdf.com/glossary/), [PDF Guides](https://peasypdf.com/guides/)

## Install

```bash
gem install peasy-pdf
```

Or add to your Gemfile:

```ruby
gem "peasy-pdf"
```

## Quick Start

```ruby
require "peasy_pdf"

client = PeasyPDF::Client.new

# List available PDF tools
tools = client.list_tools
tools["results"].each do |tool|
  puts "#{tool["name"]}: #{tool["description"]}"
end
```

## API Client

The client wraps the [PeasyPDF REST API](https://peasypdf.com/developers/) using only Ruby standard library — no external dependencies.

```ruby
require "peasy_pdf"

client = PeasyPDF::Client.new
# Or with a custom base URL:
# client = PeasyPDF::Client.new(base_url: "https://custom.example.com")

# List tools with pagination and filters
tools = client.list_tools(page: 1, limit: 10, search: "compress")

# Get a specific tool by slug
tool = client.get_tool("pdf-merge")
puts "#{tool["name"]}: #{tool["description"]}"

# Search across all content
results = client.search("compress")
puts "Found #{results["results"]["tools"].length} tools"

# Browse the glossary
glossary = client.list_glossary(search: "pdf-a")
glossary["results"].each do |term|
  puts "#{term["term"]}: #{term["definition"]}"
end

# Discover guides
guides = client.list_guides(category: "pdf")
guides["results"].each do |guide|
  puts "#{guide["title"]} (#{guide["audience_level"]})"
end

# List file format conversions
conversions = client.list_conversions(source: "pdf")

# Get format details
format = client.get_format("pdf")
puts "#{format["name"]} (#{format["extension"]}): #{format["mime_type"]}"
```

### Available Methods

| Method | Description |
|--------|-------------|
| `list_tools` | List tools (paginated, filterable) |
| `get_tool(slug)` | Get tool by slug |
| `list_categories` | List tool categories |
| `list_formats` | List file formats |
| `get_format(slug)` | Get format by slug |
| `list_conversions` | List format conversions |
| `list_glossary` | List glossary terms |
| `get_glossary_term(slug)` | Get glossary term |
| `list_guides` | List guides |
| `get_guide(slug)` | Get guide by slug |
| `list_use_cases` | List use cases |
| `search(query)` | Search across all content |
| `list_sites` | List Peasy sites |
| `openapi_spec` | Get OpenAPI specification |

All list methods accept keyword arguments: `page:`, `limit:`, `category:`, `search:`.

Full API documentation at [peasypdf.com/developers/](https://peasypdf.com/developers/).
OpenAPI 3.1.0 spec: [peasypdf.com/api/openapi.json](https://peasypdf.com/api/openapi.json).

## Learn More

- **Tools**: [PDF Merge](https://peasypdf.com/pdf/merge-pdf/) · [PDF Split](https://peasypdf.com/pdf/split-pdf/) · [PDF Compress](https://peasypdf.com/pdf/compress-pdf/) · [All Tools](https://peasypdf.com/)
- **Guides**: [PDF Compression Guide](https://peasypdf.com/guides/pdf-compression-guide/) · [How to Merge PDF Files](https://peasypdf.com/guides/how-to-merge-pdf-files/) · [All Guides](https://peasypdf.com/guides/)
- **Glossary**: [PDF](https://peasypdf.com/glossary/pdf/) · [Linearization](https://peasypdf.com/glossary/linearization/) · [OCR](https://peasypdf.com/glossary/ocr/) · [All Terms](https://peasypdf.com/glossary/)
- **Formats**: [PDF](https://peasypdf.com/formats/pdf/) · [PDF/A](https://peasypdf.com/formats/) · [All Formats](https://peasypdf.com/formats/)
- **API**: [REST API Docs](https://peasypdf.com/developers/) · [OpenAPI Spec](https://peasypdf.com/api/openapi.json)

## Also Available

| Language | Package | Install |
|----------|---------|---------|
| **Python** | [peasy-pdf](https://pypi.org/project/peasy-pdf/) | `pip install "peasy-pdf[all]"` |
| **TypeScript** | [peasy-pdf](https://www.npmjs.com/package/peasy-pdf) | `npm install peasy-pdf` |
| **Go** | [peasy-pdf-go](https://pkg.go.dev/github.com/peasytools/peasy-pdf-go) | `go get github.com/peasytools/peasy-pdf-go` |
| **Rust** | [peasy-pdf](https://crates.io/crates/peasy-pdf) | `cargo add peasy-pdf` |

## Peasy Developer Tools

Part of the [Peasy Tools](https://peasytools.com) open-source developer ecosystem.

| Package | PyPI | npm | RubyGems | Description |
|---------|------|-----|----------|-------------|
| **peasy-pdf** | [PyPI](https://pypi.org/project/peasy-pdf/) | [npm](https://www.npmjs.com/package/peasy-pdf) | [Gem](https://rubygems.org/gems/peasy-pdf) | **PDF merge, split, rotate, compress — [peasypdf.com](https://peasypdf.com)** |
| peasy-image | [PyPI](https://pypi.org/project/peasy-image/) | [npm](https://www.npmjs.com/package/peasy-image) | [Gem](https://rubygems.org/gems/peasy-image) | Image resize, crop, convert, compress — [peasyimage.com](https://peasyimage.com) |
| peasy-audio | [PyPI](https://pypi.org/project/peasy-audio/) | [npm](https://www.npmjs.com/package/peasy-audio) | [Gem](https://rubygems.org/gems/peasy-audio) | Audio trim, merge, convert, normalize — [peasyaudio.com](https://peasyaudio.com) |
| peasy-video | [PyPI](https://pypi.org/project/peasy-video/) | [npm](https://www.npmjs.com/package/peasy-video) | [Gem](https://rubygems.org/gems/peasy-video) | Video trim, resize, thumbnails, GIF — [peasyvideo.com](https://peasyvideo.com) |
| peasy-css | [PyPI](https://pypi.org/project/peasy-css/) | [npm](https://www.npmjs.com/package/peasy-css) | [Gem](https://rubygems.org/gems/peasy-css) | CSS minify, format, analyze — [peasycss.com](https://peasycss.com) |
| peasy-compress | [PyPI](https://pypi.org/project/peasy-compress/) | [npm](https://www.npmjs.com/package/peasy-compress) | [Gem](https://rubygems.org/gems/peasy-compress) | ZIP, TAR, gzip compression — [peasytools.com](https://peasytools.com) |
| peasy-document | [PyPI](https://pypi.org/project/peasy-document/) | [npm](https://www.npmjs.com/package/peasy-document) | [Gem](https://rubygems.org/gems/peasy-document) | Markdown, HTML, CSV, JSON conversion — [peasyformats.com](https://peasyformats.com) |
| peasytext | [PyPI](https://pypi.org/project/peasytext/) | [npm](https://www.npmjs.com/package/peasytext) | [Gem](https://rubygems.org/gems/peasytext) | Text case conversion, slugify, word count — [peasytext.com](https://peasytext.com) |

## License

MIT
