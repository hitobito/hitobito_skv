# frozen_string_literal: true

#  Copyright (c) 2026, Schweizerischer Kanu-Verband. This file is part of
#  hitobito_skv and licensed under the Affero General Public License version 3
#  or later. See the COPYING file at the top-level directory or at
#  https://github.com/hitobito/hitobito_skv

require "spec_helper"

describe Skv::Passes::MembershipDataProvider do
  let(:pass_definition) { pass_definitions(:skv_membership) }
  let(:person) { people(:berner_kanufahrer) }
  let(:pass) { Fabricate(:pass, person: person, pass_definition: pass_definition) }

  subject { described_class.new(pass) }

  describe "#member_number" do
    it "returns the persons membership number" do
      expect(subject.member_number).to eq(person.membership_number)
    end
  end
end
