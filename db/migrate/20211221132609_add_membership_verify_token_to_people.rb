# frozen_string_literal: true

#  Copyright (c) 2012-2021, Schweizerischer Kanu-Verband. This file is part of
#  hitobito_skv and licensed under the Affero General Public License version 3
#  or later. See the COPYING file at the top-level directory or at
#  https://github.com/hitobito/hitobito_skv.

class AddMembershipVerifyTokenToPeople < ActiveRecord::Migration[6.1]

  def change
    add_column :people, :membership_verify_token, :string, index: true, if_not_exists: true
  end

end
