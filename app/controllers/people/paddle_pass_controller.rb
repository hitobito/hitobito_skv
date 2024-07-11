# frozen_string_literal: true

#  Copyright (c) 2021, Schweizerischer Kanu-Verband. This file is part of
#  hitobito_skv and licensed under the Affero General Public License version 3
#  or later. See the COPYING file at the top-level directory or at
#  https://github.com/hitobito/hitobito_skv.

class People::PaddlePassController < ApplicationController
  def show
    authorize!(:update, person)

    respond_to do |format|
      format.pdf do
        send_data pdf.render, type: :pdf, disposition: :inline, filename: pdf_filename
      end
    end
  end

  private

  def pdf
    Export::Pdf::Passes::PaddlePass.new(person)
  end

  def person
    @person ||= Person.find(params[:id])
  end

  def pdf_filename
    "skv-paddle-pass-#{person.full_name.parameterize(separator: "-")}.pdf"
  end
end
