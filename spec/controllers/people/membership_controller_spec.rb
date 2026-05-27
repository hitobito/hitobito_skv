# frozen_string_literal: true

#  Copyright (c) 2021-2026, Schweizerischer Kanu-Verband. This file is part of
#  hitobito_skv and licensed under the Affero General Public License version 3
#  or later. See the COPYING file at the top-level directory or at
#  https://github.com/hitobito/hitobito_skv.

require "spec_helper"

describe People::MembershipController do
  let(:pass_definition) { pass_definitions(:skv_membership) }

  let(:member) do
    person = Fabricate(:person)
    Fabricate(Group::Sektion::Aktivmitglied.sti_name.to_sym,
      person: person,
      group: groups(:be_kanu_club))
    Fabricate(:pass, person: person, pass_definition: pass_definition)
    person
  end

  let(:other_person) do
    Fabricate(:person)
  end

  context "GET show" do
    it "redirects member to their pass show page" do
      sign_in(member)
      pass = member.passes.first

      get :show, params: {id: member.id}

      expect(response).to redirect_to(
        group_person_pass_path(member.primary_group, member, pass, format: :pdf)
      )
    end

    it "redirects to person page when no skv_membership pass exists" do
      sign_in(other_person)

      get :show, params: {id: other_person.id}

      expect(response).to redirect_to(person_path(other_person))
    end

    it "raises AccessDenied when accessing another person without permission" do
      sign_in(other_person)

      expect do
        get :show, params: {id: member.id}
      end.to raise_error(CanCan::AccessDenied)
    end
  end
end
