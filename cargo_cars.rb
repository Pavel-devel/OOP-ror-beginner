class CargoCars < Train
  include Manufacturer
  attr_reader :appointment

  def initialize(number, appointment)
    super
    @appointment = appointment
  end
end
