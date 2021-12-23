# frozen_string_literal: true

#  Copyright (c) 2021, Schweizerischer Kanu-Verband. This file is part of
#  hitobito_skv and licensed under the Affero General Public License version 3
#  or later. See the COPYING file at the top-level directory or at
#  https://github.com/hitobito/hitobito_skv.

require_relative 'membership/header'
require_relative 'membership/person'
require_relative 'membership/footer'

module Export::Pdf::Passes
  class Membership

    class << self
      def export(_format, person)
        new(person).render
      end
    end

    def initialize(person)
      @person = person
    end

    def render
      logo_section.render
      sections.each do |section|
        section.render
      end
      pdf.render
    end

    def pdf
      @pdf ||= Prawn::Document.new(render_options)
    end

    private

    def render_options
      @options.to_h.merge(
        page_size: 'A4',
        page_layout: :portrait
      )
    end

    def sections
      @sections ||= [Header, Person, Footer].collect do |section|
        section.new(pdf, @person, {})
      end
    end

    def logo_section
      Export::Pdf::Passes::Sections::Logo.new(pdf, @person, {})
    end

  end
end
