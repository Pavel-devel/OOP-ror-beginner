class CargoCars < Train
  attr_reader :appointment

  def initialize(number, appointment)
    super
    @appointment = appointment
  end
end
