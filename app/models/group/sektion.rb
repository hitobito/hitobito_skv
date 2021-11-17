# frozen_string_literal: true

#  Copyright (c) 2012-2021, Schweizerischer Kanu-Verband. This file is part of
#  hitobito_skv and licensed under the Affero General Public License version 3
#  or later. See the COPYING file at the top-level directory or at
#  https://github.com/hitobito/hitobito_skv.


class Group::Sektion < ::Group
  self.layer = true
  self.default_children = [
    Group::SektionVorstand
  ]

  children Group::Projektgruppe,
           Group::SektionVorstand

  class JsCoach < ::Role
    self.permissions = [:group_full]
  end

  class Junior < ::Role
    self.permissions = [:group_read]
  end

  class Aktivmitglied < ::Role
    self.permissions = [:group_read]
  end

  class Passivmitglied < ::Role
    self.permissions = [:group_read]
  end

  class Ehrenmitglied < ::Role; end

  roles JsCoach, Junior, Aktivmitglied, Passivmitglied, Ehrenmitglied
end
