# frozen_string_literal: true

#  Copyright (c) 2012-2021, Schweizerischer Kanu-Verband. This file is part of
#  hitobito_skv and licensed under the Affero General Public License version 3
#  or later. See the COPYING file at the top-level directory or at
#  https://github.com/hitobito/hitobito_skv.

class People::Membership::VerifyController < ActionController::Base

  helper_method :person

  skip_authorization_check

  def show
    render layout: false
  end

  private

  def person
    @person ||= fetch_person
  end

  def fetch_person
    token = params[:verify_token]
    return nil if token.blank?

    Person.find_by(verify_membership_token: params[:verify_token])
  end

end
