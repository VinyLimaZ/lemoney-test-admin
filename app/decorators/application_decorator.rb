# frozen_string_literal: true

class ApplicationDecorator
  def to_param
    id.to_s
  end
end
