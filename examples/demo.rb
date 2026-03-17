# frozen_string_literal: true

# Demo script for peasy-pdf-rb — PDF tools client for peasypdf.com
# Run: ruby -I lib examples/demo.rb

require "peasy_pdf"

client = PeasyPDF::Client.new

# List available PDF tools
puts "=== PDF Tools ==="
tools = client.list_tools(limit: 5)
tools["results"].each do |tool|
  puts "  #{tool["name"]}: #{tool["description"]}"
end
puts "  Total: #{tools["count"]} tools"

# Get a specific tool by slug
puts "\n=== Merge PDF Tool ==="
tool = client.get_tool("merge-pdf")
puts "  Name: #{tool["name"]}"
puts "  Description: #{tool["description"]}"

# List tool categories
puts "\n=== Categories ==="
categories = client.list_categories
categories["results"].each do |cat|
  puts "  #{cat["name"]}"
end

# Search across all content
puts "\n=== Search: 'compress' ==="
results = client.search("compress")
results["results"].each do |section, items|
  puts "  #{section}: #{items.length} results" if items.is_a?(Array) && !items.empty?
end

# List glossary terms
puts "\n=== Glossary (first 3) ==="
glossary = client.list_glossary(limit: 3)
glossary["results"].each do |term|
  puts "  #{term["term"]}: #{term["definition"]&.slice(0, 80)}..."
end

# List guides
puts "\n=== Guides (first 3) ==="
guides = client.list_guides(limit: 3)
guides["results"].each do |guide|
  puts "  #{guide["title"]}"
end

puts "\nDone! Visit https://peasypdf.com for more."
