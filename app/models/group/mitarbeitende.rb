# frozen_string_literal: true

#  Copyright (c) 2012-2021, Schweizerischer Kanu-Verband. This file is part of
#  hitobito_skv and licensed under the Affero General Public License version 3
#  or later. See the COPYING file at the top-level directory or at
#  https://github.com/hitobito/hitobito_skv.


class Group::Mitarbeitende < ::Group
  class Trainer < ::Role
    self.permissions = [:group_read]
  end

  class Mitarbeitende < ::Role
    self.permissions = [:group_read]
  end

  class BackOffice < ::Role
    self.permissions = [:layer_and_below_full, :admin]
  end

  roles Trainer, Mitarbeitende, BackOffice
end
