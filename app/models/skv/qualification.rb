module Skv::Qualification
  extend ActiveSupport::Concern

  included do
    scope :paddle_pass_relevant, -> { joins(:qualification_kind)
                                      .where(qualification_kind: { paddle_pass_relevant: true }) }
  end
end
