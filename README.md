# peasy-pdf

[![Gem Version](https://badge.fury.io/rb/peasy-pdf.svg)](https://rubygems.org/gems/peasy-pdf)
[![License: MIT](https://img.shields.io/badge/License-MIT-blue.svg)](https://opensource.org/licenses/MIT)
[![GitHub stars](https://agentgif.com/badge/github/peasytools/peasy-pdf-rb/stars.svg)](https://github.com/peasytools/peasy-pdf-rb)

Ruby client for the [PeasyPDF](https://peasypdf.com) API — merge, split, rotate, and compress PDF files. Zero dependencies beyond Ruby stdlib (Net::HTTP, JSON, URI).

Built from [PeasyPDF](https://peasypdf.com), a comprehensive PDF toolkit offering free online tools for merging, splitting, rotating, compressing, and converting PDF documents. The site includes detailed guides on PDF optimization, accessibility best practices, and format conversion, plus a glossary covering terms from linearization to OCR to PDF/A archival compliance.

> **Try the interactive tools at [peasypdf.com](https://peasypdf.com)** — [Merge PDF](https://peasypdf.com/pdf/merge-pdf/), [Split PDF](https://peasypdf.com/pdf/split-pdf/), [Compress PDF](https://peasypdf.com/pdf/compress-pdf/), [Rotate PDF](https://peasypdf.com/pdf/rotate-pdf/), and more.

<p align="center">
  <a href="https://agentgif.com/efZk75CV"><img src="https://media.agentgif.com/efZk75CV.gif" alt="peasy-pdf demo — PDF merge, split, and compress tools in Ruby terminal" width="800"></a>
</p>

## Table of Contents

- [Install](#install)
- [Quick Start](#quick-start)
- [What You Can Do](#what-you-can-do)
  - [PDF Document Operations](#pdf-document-operations)
  - [Browse Reference Content](#browse-reference-content)
  - [Search and Discovery](#search-and-discovery)
- [API Client](#api-client)
  - [Available Methods](#available-methods)
- [Learn More About PDF Tools](#learn-more-about-pdf-tools)
- [Also Available](#also-available)
- [Peasy Developer Tools](#peasy-developer-tools)
- [License](#license)

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

## What You Can Do

### PDF Document Operations

The Portable Document Format (PDF) was created by Adobe in 1993 and became an open ISO standard (ISO 32000) in 2008. Today PDF is the most widely used format for document exchange, supporting text, images, forms, digital signatures, and embedded multimedia. PeasyPDF provides tools for every common PDF workflow — from merging invoices into a single file to compressing scanned documents for email delivery.

| Operation | Slug | Description |
|-----------|------|-------------|
| Merge PDF | `pdf-merge` | Combine multiple PDF documents into one file |
| Split PDF | `pdf-split` | Extract specific pages or split into individual files |
| Compress PDF | `pdf-compress` | Reduce file size by optimizing images and removing metadata |
| Rotate PDF | `pdf-rotate` | Rotate pages by 90, 180, or 270 degrees |
| PDF to PNG | `pdf-to-png` | Convert PDF pages to high-resolution PNG images |

The PDF specification (ISO 32000-2:2020) supports a remarkably rich feature set including interactive forms (AcroForms and XFA), digital signatures with certificate chains, 3D artwork using U3D and PRC formats, embedded multimedia, and accessibility tagging for screen readers. Linearized PDFs rearrange the internal object structure so that the first page can be displayed before the entire file has been downloaded — critical for web-based PDF viewing where multi-megabyte documents need to appear instantly.

```ruby
require "peasy_pdf"

client = PeasyPDF::Client.new

# Retrieve the PDF merge tool and inspect its capabilities
tool = client.get_tool("pdf-merge")
puts "Tool: #{tool["name"]}"              # PDF merge tool name
puts "Description: #{tool["description"]}" # How merging works

# List all available PDF tools with pagination
tools = client.list_tools(page: 1, limit: 20)
puts "Total PDF tools available: #{tools["count"]}"
```

Learn more: [Merge PDF Tool](https://peasypdf.com/pdf/merge-pdf/) · [How to Merge PDF Files](https://peasypdf.com/guides/how-to-merge-pdf-files/) · [PDF Compression Guide](https://peasypdf.com/guides/pdf-compression-guide/)

### Browse Reference Content

PeasyPDF includes a comprehensive glossary of document format terminology and in-depth guides for common workflows. The glossary covers foundational concepts like PDF linearization (web-optimized PDFs that load page-by-page), OCR (optical character recognition for scanned documents), DPI (dots per inch for print-quality output), and PDF/A (the ISO 19005 archival standard used by governments and libraries worldwide).

| Term | Description |
|------|-------------|
| [PDF](https://peasypdf.com/glossary/pdf/) | Portable Document Format — ISO 32000 open standard |
| [PDF/A](https://peasypdf.com/glossary/pdfa/) | Archival PDF subset (ISO 19005) for long-term preservation |
| [DPI](https://peasypdf.com/glossary/dpi/) | Dots per inch — resolution metric for print and rasterization |
| [OCR](https://peasypdf.com/glossary/ocr/) | Optical character recognition for searchable scanned PDFs |
| [Rasterization](https://peasypdf.com/glossary/rasterization/) | Converting vector PDF content to pixel-based images |

PDF compression operates at multiple levels within the document structure. Text and vector graphics are stored as compact operator sequences in content streams, which can be compressed with Flate (zlib) encoding. Embedded images — often the largest component of a PDF — support JPEG, JPEG2000, JBIG2, and CCITT fax compression depending on the image type. A well-optimized PDF applies different compression strategies to different objects: lossy JPEG for photographs, lossless Flate for text-heavy pages, and JBIG2 for scanned black-and-white documents.

```ruby
require "peasy_pdf"

client = PeasyPDF::Client.new

# Browse the PDF glossary for document format terminology
glossary = client.list_glossary(search: "linearization")
glossary["results"].each do |term|
  puts "#{term["term"]}: #{term["definition"]}"
end

# Read a specific guide on PDF accessibility best practices
guide = client.get_guide("accessible-pdf-best-practices")
puts "Guide: #{guide["title"]} (Level: #{guide["audience_level"]})"
```

Learn more: [PDF Glossary](https://peasypdf.com/glossary/) · [Accessible PDF Best Practices](https://peasypdf.com/guides/accessible-pdf-best-practices/) · [How to Convert PDF to Images](https://peasypdf.com/guides/how-to-convert-pdf-to-images/)

### Search and Discovery

The API supports full-text search across all content types — tools, glossary terms, guides, use cases, and format documentation. Search results are grouped by content type, making it easy to find exactly what you need for a specific PDF workflow. Format conversion data covers the full matrix of source-to-target transformations, including quality considerations — converting a vector PDF to a raster format like PNG requires choosing an appropriate DPI (150 for screen viewing, 300 for print, 600 for archival), since this irreversibly flattens scalable content into a fixed pixel grid.

```ruby
require "peasy_pdf"

client = PeasyPDF::Client.new

# Search across all PDF content — tools, glossary, guides, and formats
results = client.search("compress pdf")
puts "Found #{results["results"]["tools"].length} tools"
puts "Found #{results["results"]["glossary"].length} glossary terms"
puts "Found #{results["results"]["guides"].length} guides"

# Discover format conversion paths — what can PDF convert to?
conversions = client.list_conversions(source: "pdf")
conversions["results"].each do |c|
  puts "#{c["source_format"]} -> #{c["target_format"]}"
end

# Get detailed information about a specific document format
format = client.get_format("pdf")
puts "#{format["name"]} (#{format["extension"]}): #{format["mime_type"]}"
```

| Format | Standard | Content Type | Primary Use |
|--------|----------|-------------|-------------|
| PDF | ISO 32000 | Vector + raster | Universal document exchange |
| PDF/A | ISO 19005 | Archival subset | Long-term document preservation |
| PDF/X | ISO 15930 | Print-ready subset | Pre-press and commercial printing |

Learn more: [REST API Docs](https://peasypdf.com/developers/) · [All PDF Tools](https://peasypdf.com/) · [All Formats](https://peasypdf.com/formats/)

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

## Learn More About PDF Tools

- **Tools**: [Merge PDF](https://peasypdf.com/pdf/merge-pdf/) · [Split PDF](https://peasypdf.com/pdf/split-pdf/) · [Compress PDF](https://peasypdf.com/pdf/compress-pdf/) · [Rotate PDF](https://peasypdf.com/pdf/rotate-pdf/) · [PDF to PNG](https://peasypdf.com/pdf/pdf-to-png/) · [All Tools](https://peasypdf.com/)
- **Guides**: [How to Merge PDF Files](https://peasypdf.com/guides/how-to-merge-pdf-files/) · [PDF Compression Guide](https://peasypdf.com/guides/pdf-compression-guide/) · [Accessible PDF Best Practices](https://peasypdf.com/guides/accessible-pdf-best-practices/) · [How to Convert PDF to Images](https://peasypdf.com/guides/how-to-convert-pdf-to-images/) · [All Guides](https://peasypdf.com/guides/)
- **Glossary**: [PDF](https://peasypdf.com/glossary/pdf/) · [PDF/A](https://peasypdf.com/glossary/pdfa/) · [DPI](https://peasypdf.com/glossary/dpi/) · [OCR](https://peasypdf.com/glossary/ocr/) · [Rasterization](https://peasypdf.com/glossary/rasterization/) · [All Terms](https://peasypdf.com/glossary/)
- **Formats**: [All Formats](https://peasypdf.com/formats/)
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

## Embed Widget

Embed [PeasyPdf](https://peasypdf.com) widgets on any website with [peasy-pdf-embed](https://widget.peasypdf.com):

```html
<script src="https://cdn.jsdelivr.net/npm/peasy-pdf-embed@1/dist/embed.min.js"></script>
<div data-peasypdf="entity" data-slug="example"></div>
```

Zero dependencies · Shadow DOM · 4 themes (light/dark/sepia/auto) · [Widget docs](https://widget.peasypdf.com)

## License

MIT
