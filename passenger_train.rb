require_relative 'passenger_cars'

class PassengerTrain < Train
  attr_reader :type, :passenger_cars

  def initialize(number, _carriages)
    super
    @type = 'пассажирский'
    @passenger_cars = []
  end

  def add_passenger_cars_train(passenger_car)
    @passenger_cars << passenger_car
  end
end
