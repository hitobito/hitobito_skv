# frozen_string_literal: true

#  Copyright (c) 2021, Schweizerischer Kanu-Verband. This file is part of
#  hitobito_skv and licensed under the Affero General Public License version 3
#  or later. See the COPYING file at the top-level directory or at
#  https://github.com/hitobito/hitobito_skv.

module Export::Pdf::Passes
  class Membership
    # Explicitely use the default values of prawn for margin and font to keep the current layout after changing the code
    # to use `Export::Pdf::Document` which sets those values to something else.
    MARGIN = 0.5.in
    FONT = "Helvetica"

    def initialize(person)
      @person = person
    end

    def render
      pdf.font FONT
      sections.each do |section|
        section.render
      end
      pdf.render
    end

    def pdf
      @pdf ||= Export::Pdf::Document.new(margin: MARGIN).pdf
    end

    def filename
      parts = [t(:file_name_prefix)]
      parts << Time.zone.now.year
      parts << @person.full_name.parameterize(separator: "_")
      [parts.join("-"), :pdf].join(".")
    end

    private

    def sections
      @sections ||=
        [Export::Pdf::Passes::Sections::Logo, Header, Person, Footer].collect do |section|
          section.new(pdf, @person, {})
        end
    end

    def t(key)
      I18n.t("passes.membership.#{key}")
    end
  end
end
