# frozen_string_literal: true

#  Copyright (c) 2012-2021, Schweizerischer Kanu-Verband. This file is part of
#  hitobito_skv and licensed under the Affero General Public License version 3
#  or later. See the COPYING file at the top-level directory or at
#  https://github.com/hitobito/hitobito_skv.

class Export::Pdf::Passes::Sections::Logo < Export::Pdf::Section

  LOGO_BOX_HEIGHT = 130.freeze
  LOGO = 'swiss_canoe_passes.png'.freeze

  def render
    stamped :logo
  end

  def logo(width: pdf.bounds.width, height: LOGO_BOX_HEIGHT)
    bounding_box([0, cursor], width: width, height: height) do
      image(logo_path, { position: :left, at: [-40, height + 20] })
      skv_label
    end
  end

  def skv_label
    text_box("Schweizerischer Kanu-Verband\n" \
             "Fédération Suisse de Canoë-Kayak\n" \
             "Swiss Canoe Federation",
             align: :center,
             at: [120, 90],
             size: 14.pt )
  end

  def logo_path
    image_path(LOGO)
  end

  def image_path(name)
    File.join(File.dirname(__FILE__), '../../../../../assets/images/', name)
  end

end
