# frozen_string_literal: true

#  Copyright (c) 2012-2021, Schweizerischer Kanu-Verband. This file is part of
#  hitobito_skv and licensed under the Affero General Public License version 3
#  or later. See the COPYING file at the top-level directory or at
#  https://github.com/hitobito/hitobito_skv.


class Group::SwissCanoeVorstand < ::Group
  class Praesident < ::Role
    self.permissions = [:group_full]
  end

  class Finanzchef < ::Role
    self.permissions = [:group_full, :finance]
  end

  class Vorstandsmitglied < ::Role
    self.permissions = [:group_read]
  end

  roles Praesident, Finanzchef, Vorstandsmitglied
end
