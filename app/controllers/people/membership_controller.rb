# frozen_string_literal: true

#  Copyright (c) 2021, Schweizerischer Kanu-Verband. This file is part of
#  hitobito_skv and licensed under the Affero General Public License version 3
#  or later. See the COPYING file at the top-level directory or at
#  https://github.com/hitobito/hitobito_skv.

class People::MembershipController < ApplicationController

  def show
    authorize!(:update, person)
    verify_membership!

    respond_to do |format|
      format.pdf do
        send_data pdf.render, type: :pdf, disposition: 'inline', filename: pdf.filename
      end
    end
  end

  private

  def verify_membership!
    raise 'Person is not member' unless member?
  end

  def member?
    People::MembershipVerificator.new(person).member?
  end

  def person
    @person ||= Person.find(params[:id])
  end

  def pdf
    @pdf ||= Export::Pdf::Passes::Membership.new(person)
  end

end
