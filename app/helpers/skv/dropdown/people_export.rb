# frozen_string_literal: true

#  Copyright (c) 2021, Schweizerischer Kanu-Verband. This file is part of
#  hitobito_skv and licensed under the Affero General Public License version 3
#  or later. See the COPYING file at the top-level directory or at
#  https://github.com/hitobito/hitobito_skv.

module Skv
  module Dropdown
    module PeopleExport

      def init_items
        super
        membership_pass_link
        paddle_pass_link
      end

      private

      def membership_pass_link
        return unless member?(template.entry)

        add_item(translate(:membership),
                 template.membership_path(format: :pdf),
                 target: :new)
      end

      def paddle_pass_link
        add_item(translate(:paddle_pass),
                 template.paddle_pass_group_person_path(format: :pdf),
                 target: :new)
      end

      def member?(person)
        People::MembershipVerifier.new(person).member?
      end

    end
  end
end
