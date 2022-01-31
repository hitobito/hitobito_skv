# frozen_string_literal: true

#  Copyright (c) 2021, Schweizerischer Kanu-Verband. This file is part of
#  hitobito_skv and licensed under the Affero General Public License version 3
#  or later. See the COPYING file at the top-level directory or at
#  https://github.com/hitobito/hitobito_skv.

require 'spec_helper'

describe Export::Pdf::Passes::Membership do

  let(:member) { people(:berner_kanufahrer) }
  let(:analyzer) { PDF::Inspector::Text.analyze(subject.render) }
  let(:year) { Time.zone.now.year }

  subject { described_class.new(member) }

  before do
    member.update!(address: 'Wasserstrasse 42', zip_code: '4242', town: 'Kanuto')
  end

  it 'sanitizes filename' do
    expect(subject.filename).to eq "SKV-Mitgliederausweis-#{year}-berner_kanufan.pdf"
  end

  context 'text' do

    it 'renders membership pass' do
      expect(text_with_position).to match_array [
        [260, 756, 'Schweizerischer Kanu-Verband'],
        [248, 740, 'Fédération Suisse de Canoë-Kayak'],
        [282, 723, 'Swiss Canoe Federation'],
        [131, 634, "Mitgliederausweis #{year}"],
        [66, 602, 'CH-8000 Zürich - Phone +41 43 222 40 77 - info@swisscanoe.ch - www.swisscanoe.ch'],
        [41, 528, 'Sektion'],
        [41, 557, "Mitgliedernummer"],
        [179, 528, "Kanu Club Bern"],
        [179, 557, "003-000"],
        [41, 422, 'Berner Kanufan'],
        [41, 394, 'Wasserstrasse 42'],
        [41, 365, '4242 Kanuto'],
        [36, 277, "Gültig bis: 31.12.#{year}"],
        [36, 248, 'Gilt als Wettkampflizenz. / Is regarded as competition licence.']
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
