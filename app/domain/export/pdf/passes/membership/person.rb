# frozen_string_literal: true

#  Copyright (c) 2021, Schweizerischer Kanu-Verband. This file is part of
#  hitobito_skv and licensed under the Affero General Public License version 3
#  or later. See the COPYING file at the top-level directory or at
#  https://github.com/hitobito/hitobito_skv.

class Export::Pdf::Passes::Membership

  class Person < Export::Pdf::Section

    alias_method :person, :model

    def render
      pdf.move_down(10)
      table([ ['', { image: verify_qr_code }] ])
    end

    private

    def verify_qr_code
      qr_code = RQRCode::QRCode.new(verify_url).as_png(size: 200).to_s
      StringIO.new(qr_code)
    end

    def verify_url
      host = ENV.fetch('RAILS_HOST_NAME', 'localhost:3000')
      "https://#{host}/verify_membership/#{person.membership_verify_token}"
    end
  end
end
