# frozen_string_literal: true

#  Copyright (c) 2012-2021, Schweizerischer Kanu-Verband. This file is part of
#  hitobito_skv and licensed under the Affero General Public License version 3
#  or later. See the COPYING file at the top-level directory or at
#  https://github.com/hitobito/hitobito_skv.

Rails.application.routes.draw do

  extend LanguageRouteScope

  language_scope do
    # Define wagon routes here
    
    get '/people/:id/membership' => 'people/membership#show', as: 'membership'
    get '/people/:id/paddle_pass' => 'people/paddle_pass#show', as: 'paddle_pass'
  end

end
