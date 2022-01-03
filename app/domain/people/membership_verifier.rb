# frozen_string_literal: true

#  Copyright (c) 2012-2021, Schweizerischer Kanu-Verband. This file is part of
#  hitobito_skv and licensed under the Affero General Public License version 3
#  or later. See the COPYING file at the top-level directory or at
#  https://github.com/hitobito/hitobito_skv.

class People::MembershipVerifier

  def initialize(person)
    @person = person
  end

  def member?
    @person.roles.any? do |r|
      r.kind != :external
    end
  end

end
