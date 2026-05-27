# frozen_string_literal: true

#  Copyright (c) 2026, Schweizerischer Kanu-Verband. This file is part of
#  hitobito_skv and licensed under the Affero General Public License version 3
#  or later. See the COPYING file at the top-level directory or at
#  https://github.com/hitobito/hitobito_skv

module Skv::Passes
  class MembershipDataProvider < ::Passes::WalletDataProvider
    def member_number
      pass.person.membership_number
    end
  end
end
