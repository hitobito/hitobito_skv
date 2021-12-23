# frozen_string_literal: true

#  Copyright (c) 2021, Schweizerischer Kanu-Verband. This file is part of
#  hitobito_skv and licensed under the Affero General Public License version 3
#  or later. See the COPYING file at the top-level directory or at
#  https://github.com/hitobito/hitobito_skv.

class Export::Pdf::Passes::Membership
  class Title < Export::Pdf::Section
    def render(_person)
      text(I18n.t('passes.membership.title'), size: 36, style: :bold, align: :center)
      pdf.move_down(10)
      render_skv_info
    end

    private

    def render_skv_info
      info = ['CH-8000 Zürich',
              'Phone +41 43 222 40 77',
              'info@swisscanoe.ch - www.swisscanoe.ch'].join("\n")
      text(info, align: :center)
    end

  end
end
