require_relative 'cargo_cars'

class CargoTrain < Train
  attr_reader :type, :cargo_cars

  def initialize(number, _carriages)
    super
    @type = 'грузовой'
    @cargo_cars = []
  end

  def add_cargo_cars_train(cargo_car)
    @cargo_cars << cargo_car
  end
end
