module Skv::Qualification
  extend ActiveSupport::Concern

  included do
    scope :paddle_pass_relevant, -> { joins(:qualification_kind)
                                      .where(qualification_kind: { appears_on_paddle_pass: true }) }
  end
end
