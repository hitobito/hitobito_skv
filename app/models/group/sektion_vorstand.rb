# frozen_string_literal: true

#  Copyright (c) 2012-2021, Schweizerischer Kanu-Verband. This file is part of
#  hitobito_skv and licensed under the Affero General Public License version 3
#  or later. See the COPYING file at the top-level directory or at
#  https://github.com/hitobito/hitobito_skv.


class Group::SektionVorstand < ::Group
  class Praesident < ::Role
    self.permissions = [:group_full]
  end

  class Vorstandsmitglied < ::Role
    self.permissions = [:group_full]
  end

  class Sekretaer < ::Role
    self.permissions = [:group_full]
  end

  class Kassier < ::Role
    self.permissions = [:finance]
  end

  roles Praesident, Vorstandsmitglied, Sekretaer, Kassier
end
