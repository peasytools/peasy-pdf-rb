# frozen_string_literal: true

require "minitest/autorun"
require "peasy_pdf"

class TestPeasyPDF < Minitest::Test
  def test_version
    refute_nil PeasyPDF::VERSION
    assert_equal "0.1.1", PeasyPDF::VERSION
  end
end
