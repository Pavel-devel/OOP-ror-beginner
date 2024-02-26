require_relative 'passenger_cars'

class PassengerTrain < Train
  attr_reader :type, :passenger_cars, :number

  def initialize(number, _carriages)
    super
    @type = 'пассажирский'
    @passenger_cars = []
  end

  def add_passenger_cars_train(passenger_car)
    @passenger_cars << passenger_car
  end

  def delete_cars(passenger_car)
    @passenger_cars.delete(passenger_car)
  end

  def number_of_cars
    passenger_cars.length
  end

  def show_number_passenger_cars
    passenger_cars.each(&:number)
  end
end
