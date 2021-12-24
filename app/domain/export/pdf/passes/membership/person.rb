# frozen_string_literal: true

#  Copyright (c) 2021, Schweizerischer Kanu-Verband. This file is part of
#  hitobito_skv and licensed under the Affero General Public License version 3
#  or later. See the COPYING file at the top-level directory or at
#  https://github.com/hitobito/hitobito_skv.

class Export::Pdf::Passes::Membership

  class Person < Export::Pdf::Section

    alias person model

    def render
      pdf.move_down(10)
      table([
        [member_data_column, { image: verify_qr_code }]
      ], cell_style: { border_width: 0 })
    end

    private

    def member_data_column
      attrs = [[t('member'), 'tbd'], [t('group'), group_name]]
      [[attrs],
       [person_address]]
    end

    def person_address
      person.address_for_letter
    end

    def verify_qr_code
      qr_code = RQRCode::QRCode.new(verify_url).as_png(size: 200).to_s
      StringIO.new(qr_code)
    end

    def verify_url
      host = ENV.fetch('RAILS_HOST_NAME', 'localhost:3000')
      "https://#{host}/verify_membership/#{membership_verify_token}"
    end

    def membership_verify_token
      person.membership_verify_token.presence || person.init_membership_verify_token!
    end

    def group_name
      group = person.primary_group.presence || person.groups.first
      group.name
    end

    def t(key)
      I18n.t("passes.membership.#{key}")
    end

  end
end
