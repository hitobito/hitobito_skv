# frozen_string_literal: true

#  Copyright (c) 2012-2021, Schweizerischer Kanu-Verband. This file is part of
#  hitobito_skv and licensed under the Affero General Public License version 3
#  or later. See the COPYING file at the top-level directory or at
#  https://github.com/hitobito/hitobito_skv.

class AddAppearsOnPaddlePassToQualificationKinds < ActiveRecord::Migration[6.1]
  def change
    add_column :qualification_kinds, :appears_on_paddle_pass, :boolean, default: false, null: false
  end
end
