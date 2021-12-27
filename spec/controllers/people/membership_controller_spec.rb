# frozen_string_literal: true

#  Copyright (c) 2021, Schweizerischer Kanu-Verband. This file is part of
#  hitobito_skv and licensed under the Affero General Public License version 3
#  or later. See the COPYING file at the top-level directory or at
#  https://github.com/hitobito/hitobito_skv.

require 'spec_helper'

describe People::MembershipController do

  let(:member) { people(:berner_kanufahrer) }
  let(:vorstand) do
    Fabricate('Group::KantonalverbandVorstand::Vorstandsmitglied',
              group: groups(:be_vorstand)).person
  end
  context 'GET show' do
    it 'is possible to download own membership pass' do
      sign_in(member)

      get :show, params: { id: member.id, format: 'pdf' }

      expect(response.status).to eq(200)
    end

    it 'is possible to download membership pass for writable person' do
      sign_in(vorstand)

      get :show, params: { id: member.id, format: 'pdf' }

      expect(response.status).to eq(200)
    end

    it 'is not possible to download membership pass without access to person' do
      sign_in(member)

      expect do
        get :show, params: { id: vorstand.id, format: 'pdf' }
      end.to raise_error(CanCan::AccessDenied)
    end

    context 'non member' do
      let(:mitarbeiter) do
        gl = Fabricate('Group::Geschaeftsleitung', name: 'GL', parent: Group.root)
        Fabricate('Group::Geschaeftsleitung::Mitarbeitende', group: gl).person
      end

      let(:non_member) do
        ext = Fabricate('Group::ExterneKontakte', name: 'Extern', parent: Group.root)
        Fabricate('Group::ExterneKontakte::ExternerKontakt', group: ext).person
      end

      it 'is not possible to download membership pass' do
        sign_in(mitarbeiter)

        expect do
          get :show, params: { id: non_member.id, format: 'pdf' }
        end.to raise_error('Person is not member')
      end
    end

  end

end
