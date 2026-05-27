# frozen_string_literal: true

#  Copyright (c) 2026, Schweizerischer Kanu-Verband. This file is part of
#  hitobito_skv and licensed under the Affero General Public License version 3
#  or later. See the COPYING file at the top-level directory or at
#  https://github.com/hitobito/hitobito_skv

Rails.application.config.to_prepare do
  Passes::TemplateRegistry.register("skv_membership",
    pdf_class: Skv::Export::Pdf::Passes::Membership,
    pass_view_partial: "skv_membership",
    wallet_data_provider: Skv::Passes::MembershipDataProvider
  )
end
