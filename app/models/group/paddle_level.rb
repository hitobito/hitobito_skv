# frozen_string_literal: true

#  Copyright (c) 2012-2021, Schweizerischer Kanu-Verband. This file is part of
#  hitobito_skv and licensed under the Affero General Public License version 3
#  or later. See the COPYING file at the top-level directory or at
#  https://github.com/hitobito/hitobito_skv.

class Group::PaddleLevel < ::Group

  class Anbieter < ::Role
    self.permissions = [:group_read]
  end

  class Assessor < ::Role
    self.permissions = [:group_read]
  end

  class Koordinator < ::Role
    self.permissions = [:group_read]
  end

  roles Anbieter, Assessor, Koordinator

end
