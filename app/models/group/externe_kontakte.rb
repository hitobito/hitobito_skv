# frozen_string_literal: true

#  Copyright (c) 2012-2021, Schweizerischer Kanu-Verband. This file is part of
#  hitobito_skv and licensed under the Affero General Public License version 3
#  or later. See the COPYING file at the top-level directory or at
#  https://github.com/hitobito/hitobito_skv.

class Group::ExterneKontakte < ::Group
  class ExternerKontakt < ::Role
    self.kind = :external
  end
  class SwissCanoePartner < ::Role
    self.kind = :external
  end

  roles ExternerKontakt, SwissCanoePartner
end
