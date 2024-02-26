require_relative 'cargo_cars'

class CargoTrain < Train
  attr_reader :type, :cargo_cars, :number

  def initialize(number, _carriages)
    super
    @type = 'грузовой'
    @cargo_cars = []
  end

  def add_cargo_cars_train(cargo_car)
    @cargo_cars << cargo_car
  end

  def delete_cars(cargo_car)
    @cargo_cars.delete(cargo_car)
  end

  def number_of_cars
    cargo_cars.length
  end

  def show_number_of_cars
    cargo_cars.each(&:number)
  end
end
