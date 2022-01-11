# frozen_string_literal: true

#  Copyright (c) 2022, Swiss Canoe. This file is part of
#  hitobito_skv and licensed under the Affero General Public License version 3
#  or later. See the COPYING file at the top-level directory or at
#  https://github.com/hitobito/hitobito_skv.

require 'spec_helper'

describe PeopleController do

  let(:top_leader) { roles(:praesident).person }
  let(:top_member) { roles(:vorstandsmitglied).person }
  let(:non_member) { roles(:non_member).person }

  context 'GET show' do
    context 'documents section' do
      render_views
      subject { dom }

      let(:group) { person.groups.first }
      let(:dom) { Capybara::Node::Simple.new(response.body) }

      before do
        sign_in(me)
        get :show, params: { group_id: group.id, id: person.id }
      end

      context 'for myself' do
        let(:me) { top_member }
        let(:person) { top_member }

        it { is_expected.to have_content 'Dokumente' }
        it { is_expected.to have_content 'Mitgliederausweis' }
        it { is_expected.to have_content 'Paddle Level Card' }
      end

      context 'for someone I can update' do
        let(:me) { top_leader }
        let(:person) { top_member }

        it { is_expected.to have_content 'Dokumente' }
        it { is_expected.to have_content 'Mitgliederausweis' }
        it { is_expected.to have_content 'Paddle Level Card' }
      end

      context 'for someone I cannot update' do
        let(:me) { top_member }
        let(:person) { top_leader }

        it { is_expected.not_to have_content 'Dokumente' }
        it { is_expected.not_to have_content 'Mitgliederausweis' }
        it { is_expected.not_to have_content 'Paddle Level Card' }
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
