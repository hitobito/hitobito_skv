# frozen_string_literal: true

#  Copyright (c) 2021, Schweizerischer Kanu-Verband. This file is part of
#  hitobito_skv and licensed under the Affero General Public License version 3
#  or later. See the COPYING file at the top-level directory or at
#  https://github.com/hitobito/hitobito_skv.

module Export::Pdf::Passes
  class PaddlePass
    def initialize(person, options = {})
      @person = person
      @options = options
    end

    def pdf
      @pdf ||= Export::Pdf::Document.new(margin: 0.5.in, **@options).pdf.tap { _1.font "Helvetica" }
    end

    def render
      render_sections
      pdf.render_file("/tmp/test.pdf")
      pdf.render
    end

    def render_sections
      sections.each do |section|
        section.render
      end
    end

    def sections
      @sections ||= [Sections::Logo, Content].collect do |section|
        section.new(pdf, @person, @options)
      end
    end
  end
end
