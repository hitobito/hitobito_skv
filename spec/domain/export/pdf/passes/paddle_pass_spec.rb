# frozen_string_literal: true

#  Copyright (c) 2021, Schweizerischer Kanu-Verband. This file is part of
#  hitobito_skv and licensed under the Affero General Public License version 3
#  or later. See the COPYING file at the top-level directory or at
#  https://github.com/hitobito/hitobito_skv.

require "spec_helper"

describe Export::Pdf::Passes::PaddlePass do
  let(:member) { people(:berner_kanufahrer) }
  let(:analyzer) { PDF::Inspector::Text.analyze(subject.render) }
  let(:year) { Time.zone.now.year }

  subject { described_class.new(member) }

  before do
    member.update!(street: "Wasserstrasse", housenumber: 42, zip_code: "4242", town: "Kanuto")

    [{label: "Paddle Level 4 Whitewater Kayak", start_at: Date.new(2019, 3, 2)},
      {label: "Paddle Level 3 Seakayak", start_at: Date.new(year - 2, 6, 20)},
      {label: "Paddle Level 3 Touring", start_at: Date.new(2019, 7, 10)},
      {label: "Paddle Level 2 SUP", start_at: Date.new(year - 1, 10, 23)}].each do |attrs|
      kind = Fabricate(:qualification_kind, label: attrs[:label], paddle_pass_relevant: true)

      Fabricate(:qualification, person: member, qualification_kind: kind, start_at: attrs[:start_at])
    end
  end

  context "text" do
    it "renders paddle pass" do
      expect(text_with_position).to eq [
        [260, 756, "Schweizerischer Kanu-Verband"],
        [248, 740, "Fédération Suisse de Canoë-Kayak"],
        [282, 723, "Swiss Canoe Federation"],
        [169, 634, "Paddle Level Card"],
        [255, 612, "CH-8000 Zürich"],
        [232, 598, "Phone +41 43 222 40 77"],
        [185, 584, "info@swisscanoe.ch - www.swisscanoe.ch"],
        [41, 539, "Vorname/Name"],
        [310, 539, "Berner Kanufan"],
        [41, 503, "Mitgliedernummer"],
        [310, 503, "418-312-524"],
        [41, 468, "Club/Organisation"],
        [310, 468, "Kanu Club Bern"],
        [41, 411, "Paddle Level 3 Seakayak"],
        [340, 411, "06/#{year - 2}"],
        [41, 384, "Paddle Level 2 SUP"],
        [340, 384, "10/#{year - 1}"]
      ]
    end
  end

  private

  def text_with_position
    analyzer.positions.each_with_index.collect do |p, i|
      p.collect(&:round) + [analyzer.show_text[i]]
    end
  end
end
