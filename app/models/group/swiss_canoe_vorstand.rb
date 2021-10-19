# frozen_string_literal: true

#  Copyright (c) 2012-2021, Swiss Canoe. This file is part of
#  hitobito_skv and licensed under the Affero General Public License version 3
#  or later. See the COPYING file at the top-level directory or at
#  https://github.com/hitobito/hitobito_skv.


class Group::SwissCanoeVorstand < ::Group

  class Praesident < Role
    self.permissions = [:layer_and_below_full, :contact_data, :finance]
  end

  class Kassier < Role
    self.permissions = []
  end

  class Mitglied < Role
    self.permissions = []
  end

  roles Praesident, Kassier, Mitglied

end
