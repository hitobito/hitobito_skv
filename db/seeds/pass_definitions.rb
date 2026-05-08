# frozen_string_literal: true

#  Copyright (c) 2026, Schweizerischer Kanu-Verband. This file is part of
#  hitobito_skv and licensed under the Affero General Public License version 3
#  or later. See the COPYING file at the top-level directory or at
#  https://github.com/hitobito/hitobito_skv

skv_group = Group::SwissCanoe.first!

PassDefinition.find_or_create_by!(id: 1) do |pd|
  pd.owner = skv_group
  pd.template_key = "skv_membership"
  pd.name = "Mitgliederausweis"
  pd.description = "Mitgliederausweis des Schweizerischen Kanu-Verbands"

  grant = pd.pass_grants.build(grantor: skv_group)

  Role.all_types
    .reject { |role_type| role_type.kind == :external }
    .each { |role_type| grant.related_role_types.build(role_type: role_type.sti_name) }
end
