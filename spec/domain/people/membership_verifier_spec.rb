# frozen_string_literal: true

#  Copyright (c) 2012-2021, Schweizerischer Kanu-Verband. This file is part of
#  hitobito_skv and licensed under the Affero General Public License version 3
#  or later. See the COPYING file at the top-level directory or at
#  https://github.com/hitobito/hitobito_skv.

require 'spec_helper'

describe People::MembershipVerifier do

  let(:verifier) { described_class.new(person) }
  let(:person) { people(:berner_kanufahrer) }
  let!(:external_group) { Group::ExterneKontakte.create!(parent: Group.root, name: 'Extis') }

  context '#member?' do
    it 'returns true if person has member role' do
      expect(verifier.member?).to eq(true)
    end

    it 'returns true if person has any non external role' do
      Fabricate(Group::ExterneKontakte::ExternerKontakt.name.to_sym,
                group: external_group, person: person)

      expect(verifier.member?).to eq(true)
    end

    it 'returns false if person has no role' do
      person.roles.destroy_all

      expect(verifier.member?).to eq(false)
    end

    it 'returns false if person has only external role' do
      person.roles.destroy_all
      Fabricate(Group::ExterneKontakte::ExternerKontakt.name.to_sym,
                group: external_group, person: person)

      expect(verifier.member?).to eq(false)
    end
  end

end
