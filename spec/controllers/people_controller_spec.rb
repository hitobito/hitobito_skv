# frozen_string_literal: true

#  Copyright (c) 2022, Swiss Canoe. This file is part of
#  hitobito_skv and licensed under the Affero General Public License version 3
#  or later. See the COPYING file at the top-level directory or at
#  https://github.com/hitobito/hitobito_skv.

require 'spec_helper'

describe PeopleController do

  let(:top_leader) { people(:gl_mitarbeitende) }
  let(:bern_member) { people(:berner_kanufahrer) }
  let(:non_member) { people(:non_member) }

  context 'GET show' do
    context 'documents section' do
      render_views
      subject { dom }

      let(:group) { person.groups.first }
      let(:dom) { Capybara::Node::Simple.new(response.body) }

      before do
        sign_in(me)
        Fabricate(:pass, person: top_leader, pass_definition: pass_definitions(:skv_membership))
        Fabricate(:pass, person: bern_member, pass_definition: pass_definitions(:skv_membership))
        get :show, params: { group_id: group.id, id: person.id }
      end

      context 'for myself' do
        let(:me) { top_leader }
        let(:person) { top_leader }

        it { is_expected.to have_content 'Dokumente' }
        it { is_expected.to have_content 'Mitgliederausweis' }
        it { is_expected.to have_content 'Paddle Level Card' }
      end

      context 'for someone I can show_full' do
        let(:me) { top_leader }
        let(:person) { bern_member }

        it { is_expected.to have_content 'Dokumente' }
        it { is_expected.to have_content 'Mitgliederausweis' }
        it { is_expected.to have_content 'Paddle Level Card' }
      end

      context 'for someone I can show but not show_full' do
        let(:me) { top_leader }
        let(:person) { bern_member }

        before do
          Fabricate(Group::SwissCanoeVorstand::Finanzchef.sti_name, group: groups(:swiss_canoe_vorstand), person: bern_member)
          allow_any_instance_of(Group::SwissCanoeVorstand::Finanzchef).to receive(:permissions).and_return([:group_read])
        end

        it { is_expected.to have_content 'Dokumente' }
        it { is_expected.to have_content 'Mitgliederausweis' }
        it { is_expected.to have_content 'Paddle Level Card' }
      end

      context 'for myself as non-member' do
        let(:me) { non_member }
        let(:person) { non_member }

        it { is_expected.to have_content 'Dokumente' }
        it { is_expected.not_to have_content 'Mitgliederausweis' }
        it { is_expected.to have_content 'Paddle Level Card' }
      end
    end
  end

end
