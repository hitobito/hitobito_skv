# frozen_string_literal: true

#  Copyright (c) 2026, Schweizerischer Kanu-Verband. This file is part of
#  hitobito_skv and licensed under the Affero General Public License version 3
#  or later. See the COPYING file at the top-level directory or at
#  https://github.com/hitobito/hitobito_skv

require "spec_helper"

describe Passes::VerificationsController do
  let(:person) { people(:berner_kanufahrer) }
  let(:pass_definition) { pass_definitions(:skv_membership) }
  let!(:pass) { Fabricate(:pass, person: person, pass_definition: pass_definition) }

  # Do not raise server errors to avoid "No route matches [GET] /favicon.ico" in requests without user
  before { Capybara.raise_server_errors = false }

  it "shows invalid token information" do
    visit "/passes/verify/nOnExistentTOOKen"
    expect(page).to have_text "Dieser Pass konnte nicht verifiziert werden"
  end

  context "with valid token" do
    it "shows expired membership information" do
      pass.update!(state: :ended)

      visit "/passes/verify/#{pass.verify_token}"

      expect(page).to have_css(".alert-warning", text: "Pass ist abgelaufen")
    end

    it "shows valid membership information" do
      visit "/passes/verify/#{pass.verify_token}"

      expect(page).to have_text person.full_name
      expect(page).to have_css(".alert-success", text: "Pass ist gültig")
    end
  end
end
