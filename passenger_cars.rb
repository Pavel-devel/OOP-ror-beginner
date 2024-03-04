class PassengerCars < Train
  include Manufacturer
  attr_reader :number_seats

  def initialize(number, number_seats)
    super
    @number_seats = number_seats
  end
end
