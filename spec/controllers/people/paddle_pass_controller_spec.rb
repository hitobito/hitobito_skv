# frozen_string_literal: true

#  Copyright (c) 2021, Schweizerischer Kanu-Verband. This file is part of
#  hitobito_skv and licensed under the Affero General Public License version 3
#  or later. See the COPYING file at the top-level directory or at
#  https://github.com/hitobito/hitobito_skv.

require 'spec_helper'

describe People::PaddlePassController do

  let(:member) { people(:berner_kanufahrer) }
  let(:be_vorstand) do
    Fabricate('Group::KantonalverbandVorstand', parent: groups(:be))
  end
  let(:vorstand) do
    Fabricate('Group::KantonalverbandVorstand::Vorstandsmitglied',
              group: be_vorstand).person
  end

  context 'GET show' do
    it 'is possible to download own paddle pass' do
      sign_in(member)

      get :show, params: { group_id: vorstand.id, id: member.id, format: 'pdf' }

      expect(response.status).to eq(200)
    end

    it 'is possible to download paddle pass for writable person' do
      sign_in(vorstand)

      get :show, params: { group_id: vorstand.id, id: member.id, format: 'pdf' }

      expect(response.status).to eq(200)
    end

    it 'is not possible to download paddle pass without access to person' do
      sign_in(member)

      root = groups(:swiss_canoe)
      praesident = people(:praesident)

      expect do
        get :show, params: { group_id: root.id, id: praesident.id, format: 'pdf' }
      end.to raise_error(CanCan::AccessDenied)
    end
  end

end
