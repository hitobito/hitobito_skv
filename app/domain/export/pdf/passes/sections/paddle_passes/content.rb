module Export::Pdf::Passes::Sections::PaddlePasses
  class Content < Export::Pdf::Section
    alias_method :person, :model

    PERSON_INFO_BOX = [300, 80]
    PADDLE_LEVELS_BOX = [400, 300]

    def render
      pdf.move_down 2.cm

      stamped :title

      stamped :skv_info

      pdf.move_down 5.mm

      stamped :person_info

      pdf.move_down 5.mm

      stamped :paddle_levels
    end

    private

    def title
      text('Paddle Level Card', size: 22.pt, style: :bold, align: :center)
    end

    def skv_info
      info = ['CH-8000 Zürich',
              'Phone +41 43 222 40 77',
              'info@swisscanoe.ch - www.swisscanoe.ch'].join("\n")
      text(info, align: :center)
    end

    def person_info(width: pdf.bounds.width, height: PERSON_INFO_BOX.second)
      font_size(20.pt)

      bounding_box([0, cursor], width: width, height: height) do
        table([ ['Vorname/Name', person.full_name], ['Club/Organisation', club_name] ],
              width: width,
              cell_style: { borders: [] } )
      end
    end

    def paddle_levels(width: pdf.bounds.width, height: PADDLE_LEVELS_BOX.second)
      font_size(12.pt)

      bounding_box([0, cursor], width: width, height: height) do
        if paddle_level_table_entries.present?
          table(paddle_level_table_entries,
                width: width,
                cell_style: { borders: [] })
        end
      end
    end

    def paddle_level_table_entries
      @paddle_level_table_entries ||= fetch_paddle_level_table_entries    
    end

    def fetch_paddle_level_table_entries
      person.qualifications.paddle_pass_relevant
        .select(&:active?)
        .each_with_index.map do |qualification, i|
          ["Paddle Level #{i + 1}", qualification.qualification_kind.to_s, qualification.start_at]
      end
    end

    def club_name
      layer = group&.layer_group
      layer.short_name || layer.name
    end

    def group
      person.primary_group || person.groups.first
    end
  end
end
