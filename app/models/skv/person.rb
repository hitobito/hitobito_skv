# frozen_string_literal: true

#  Copyright (c) 2012-2021, Schweizerischer Kanu-Verband. This file is part of
#  hitobito_skv and licensed under the Affero General Public License version 3
#  or later. See the COPYING file at the top-level directory or at
#  https://github.com/hitobito/hitobito_skv.

module Skv::Person
  extend ActiveSupport::Concern

  def membership_number
    id.to_s.rjust(6, "0").scan(/.{1,3}/).join("-")
  end
end
