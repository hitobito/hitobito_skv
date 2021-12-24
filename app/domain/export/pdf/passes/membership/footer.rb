# frozen_string_literal: true

#  Copyright (c) 2021, Schweizerischer Kanu-Verband. This file is part of
#  hitobito_skv and licensed under the Affero General Public License version 3
#  or later. See the COPYING file at the top-level directory or at
#  https://github.com/hitobito/hitobito_skv.

class Export::Pdf::Passes::Membership
  class Footer < Export::Pdf::Section

    def render
      image(sponsors_image_path)
    end

    private

    def sponsors_image_path
      image_path('sponsors_membership_pass.png')
    end

    def image_path(name)
      File.join(File.dirname(__FILE__), '../../../../../assets/images/', name)
    end

  end
end
