# frozen_string_literal: true

#  Copyright (c) 2012-2021, Swiss Canoe. This file is part of
#  hitobito_skv and licensed under the Affero General Public License version 3
#  or later. See the COPYING file at the top-level directory or at
#  https://github.com/hitobito/hitobito_skv.


class Group::SwissCanoeKantonalverbaende < ::Group

  self.layer = true

  children Group::Vorstand,
           Group::SwissCanoeKantonalverbaende

  ### ROLES
  self.default_children = [
    Group::Vorstand,
    Group::SwissCanoeKantonalverbaende
  ]

end
