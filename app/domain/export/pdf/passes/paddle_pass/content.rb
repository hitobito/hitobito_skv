# frozen_string_literal: true

#  Copyright (c) 2021, Schweizerischer Kanu-Verband. This file is part of
#  hitobito_skv and licensed under the Affero General Public License version 3
#  or later. See the COPYING file at the top-level directory or at
#  https://github.com/hitobito/hitobito_skv.

class Export::Pdf::Passes::PaddlePass
  class Content < Export::Pdf::Section
    alias_method :person, :model

    PERSON_INFO_BOX = [300, 120]
    PADDLE_LEVELS_BOX = [400, 300]

    EPP_LOGO = "epp_paddle_pass.png"

    def render
      pdf.move_down 20

      stamped :title
      stamped :skv_info

      pdf.move_down 5.mm

      stamped :person_info

      pdf.move_down 5.mm

      stamped :paddle_levels
      stamped :epp_logo
    end

    private

    def title
      text(t(:title), size: 30, style: :bold, align: :center)
    end

    def skv_info
      info = ["CH-8000 Zürich",
        "Phone +41 43 222 40 77",
        "info@swisscanoe.ch - www.swisscanoe.ch"].join("\n")
      text(info, align: :center)
    end

    def person_info(width: pdf.bounds.width, height: PERSON_INFO_BOX.second)
      font_size(22.pt)

      bounding_box([0, cursor], width: width, height: height) do
        table([[t(:full_name), person.full_name],
          [t(:membership_number), person.membership_number],
          [t(:club), club_name]],
          width: width,
          cell_style: {borders: []})
      end
    end

    def paddle_levels(width: pdf.bounds.width, height: PADDLE_LEVELS_BOX.second)
      font_size(15.pt)

      bounding_box([0, cursor], width: width, height: height) do
        if paddle_level_table_entries.present?
          table(paddle_level_table_entries,
            width: width,
            cell_style: {borders: []})
        end
      end
    end

    def epp_logo
      image(image_path(EPP_LOGO), {position: :left, at: [20, 24]})
    end

    def paddle_level_table_entries
      @paddle_level_table_entries ||= fetch_paddle_level_table_entries
    end

    def fetch_paddle_level_table_entries
      person.qualifications.paddle_pass_relevant
        .select(&:active?)
        .each_with_index.map do |qualification, i|
        [qualification.qualification_kind.to_s, qualification.start_at.strftime("%m/%Y")]
      end
    end

    def club_name
      layer = group&.layer_group
      return if layer.nil?

      layer.short_name || layer.name
    end

    def group
      person.primary_group || person.groups.first
    end

    def image_path(name)
      Wagons.find_wagon(__FILE__).root.join("app", "assets", "images", name)
    end

    def t(key)
      I18n.t("passes.paddle_pass.#{key}")
    end
  end
end
