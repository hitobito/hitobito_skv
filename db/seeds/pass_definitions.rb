# frozen_string_literal: true

#  Copyright (c) 2026, Schweizerischer Kanu-Verband. This file is part of
#  hitobito_skv and licensed under the Affero General Public License version 3
#  or later. See the COPYING file at the top-level directory or at
#  https://github.com/hitobito/hitobito_skv

skv_group = Group::SwissCanoe.first!

def read_image(name)
  File.open(HitobitoSkv::Wagon.config.root.join("app/assets/images/wallets").join(name))
end

id = Settings.passes.membership_pass_definition_id
PassDefinition.find_or_create_by!(id:) do |pd|
  pd.owner = skv_group
  pd.template_key = "skv_membership"
  pd.name = "Mitgliederausweis"
  pd.description = "Mitgliederausweis des Schweizerischen Kanu-Verbands"

  # Attach logo banners for all languages
  pd.logo_banner_de.attach(io: read_image("banner.png"), filename: "banner.png")
  pd.logo_banner_fr.attach(io: read_image("banner.png"), filename: "banner.png")

  # Attach logo icon only for German (fallback for all languages)
  pd.logo_icon_de.attach(io: read_image("icon.png"), filename: "icon.png")

  grant = pd.pass_grants.build(grantor: skv_group)

  Role.all_types
    .reject { |role_type| role_type.kind == :external }
    .each { |role_type| grant.related_role_types.build(role_type: role_type.sti_name) }
end
