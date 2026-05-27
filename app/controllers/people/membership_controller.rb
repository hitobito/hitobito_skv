# frozen_string_literal: true

#  Copyright (c) 2021-2026, Schweizerischer Kanu-Verband. This file is part of
#  hitobito_skv and licensed under the Affero General Public License version 3
#  or later. See the COPYING file at the top-level directory or at
#  https://github.com/hitobito/hitobito_skv.

class People::MembershipController < ApplicationController
  def show
    authorize!(:show, person)
    pass = person.passes.joins(:pass_definition)
      .find_by(pass_definitions: {id: Settings.passes.membership_pass_definition_id})
    if pass
      redirect_to group_person_pass_path(person.default_group_id, person, pass, format: :pdf)
    else
      redirect_to person_path(person)
    end
  end

  private

  def person
    @person ||= Person.find(params[:id])
  end
end
