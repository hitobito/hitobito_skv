# frozen_string_literal: true

#  Copyright (c) 2012-2021, Schweizerischer Kanu-Verband. This file is part of
#  hitobito_skv and licensed under the Affero General Public License version 3
#  or later. See the COPYING file at the top-level directory or at
#  https://github.com/hitobito/hitobito_skv.

class People::MembershipController < ApplicationController

  def show
    respond_to do |format|
      format.pdf do
        render_pdf
      end
    end
  end

  private

  def person
    @person ||= Person.find(params[:id])
  end

  def render_pdf
    Export::Pdf::Passes::Membership.new(person).render
  end


end
