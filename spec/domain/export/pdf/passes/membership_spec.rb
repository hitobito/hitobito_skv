# frozen_string_literal: true

#  Copyright (c) 2021-2026, Schweizerischer Kanu-Verband. This file is part of
#  hitobito_skv and licensed under the Affero General Public License version 3
#  or later. See the COPYING file at the top-level directory or at
#  https://github.com/hitobito/hitobito_skv.

require "spec_helper"

describe Skv::Export::Pdf::Passes::Membership do
  let(:pass_definition) { pass_definitions(:skv_membership) }
  let(:member) { people(:berner_kanufahrer) }
  let(:pass) { Fabricate(:pass, person: member, pass_definition: pass_definition) }
  let(:pdf) { subject.render }
  let(:page_analysis) { PDF::Inspector::Page.analyze(pdf) }

  subject { described_class.new(pass) }

  before do
    member.update!(street: "Wasserstrasse", housenumber: "42", zip_code: "4242", town: "Kanuto")
  end

  it "renders without error" do
    expect { pdf }.not_to raise_error
  end

  it "has one page" do
    expect(page_analysis.pages.size).to eq(1)
  end
end
