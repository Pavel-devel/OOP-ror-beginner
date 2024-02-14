require_relative 'station'
require_relative 'route'
require_relative 'trains'

# Создаем станции
station1 = Station.new("Первая станция")
station2 = Station.new("Вторая станция")
station3 = Station.new("Третья станция")

# Создаем маршрут и добавляем станции
route = Route.new(station1, station3)
route.add_station(station2)

# Создаем пассажирский поезд и грузовой поезд
passenger_train = PassengerTrain.new("Пассажирский поезд", 1)
cargo_train = CargoTrain.new("Грузовой поезд", 1)

# Добавляем маршрут к поездам
passenger_train.add_route(route)
cargo_train.add_route(route)

# Создаем пассажирские и грузовые вагоны
passenger_car1 = PassengerCars.new("Пассажирский вагон 1", 50)
passenger_car2 = PassengerCars.new("Пассажирский вагон 2", 40)
cargo_car1 = CargoCars.new("Грузовой вагон 1", "Контейнеры")
cargo_car2 = CargoCars.new("Грузовой вагон 2", "Бревна")

# Добавляем вагоны к поездам
passenger_train.add_passenger_cars_train(passenger_car1)
passenger_train.add_passenger_cars_train(passenger_car2)
cargo_train.add_cargo_cars_train(cargo_car1)
cargo_train.add_cargo_cars_train(cargo_car2)

# Перемещаем поезда по маршруту
passenger_train.move_to_next_station
cargo_train.move_to_next_station
passenger_train.move_to_next_station

# Отображаем текущую станцию поездов
puts "Текущая станция пассажирского поезда: #{passenger_train.current_station.name}"
puts "Текущая станция грузового поезда: #{cargo_train.current_station.name}"

# Отображаем типы поездов на станции
station1.show_type_trains
