# frozen_string_literal: true

#  Copyright (c) 2012-2021, Schweizerischer Kanu-Verband. This file is part of
#  hitobito_skv and licensed under the Affero General Public License version 3
#  or later. See the COPYING file at the top-level directory or at
#  https://github.com/hitobito/hitobito_skv.

module Skv::Person
  extend ActiveSupport::Concern

  included do
    validates :membership_verify_token, uniqueness: { allow_blank: true }
  end

  def membership_verify_token
    token = read_attribute(:membership_verify_token)
    token.presence || init_membership_verify_token!
  end

  def init_membership_verify_token!
    token = SecureRandom.base58(24)
    update!(membership_verify_token: token)
    token
  end
end
