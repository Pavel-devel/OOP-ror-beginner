module Validate
  def valid?
    validate!
  rescue StandardError
    false
  end
end
