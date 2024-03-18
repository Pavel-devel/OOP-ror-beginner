require_relative 'instance_counter'
require_relative 'manufacturer'
require_relative 'validate'
require_relative 'station'
require_relative 'train'
require_relative 'route'
require_relative 'passenger_train'
require_relative 'passenger_cars'
require_relative 'cargo_train'
require_relative 'cargo_cars'

class Main
  def initialize
    @stations = []
    @trains = []
    @routes = []
  end

  def menu
    loop do
      puts "Выберите действие:"
      puts "1. Создать станцию"
      puts "2. Создать поезд"
      puts "3. Создать маршрут"
      puts "4. Управлять станциями в маршруте"
      puts "5. Назначить маршрут поезду"
      puts "6. Добавить вагон к поезду"
      puts "7. Отцепить вагон от поезда"
      puts "8. Переместить поезд по маршруту вперед"
      puts "9. Переместить поезд по маршруту назад"
      puts "10. Просмотреть список станций и список поездов на станции"
      puts "0. Выйти"

      choice = gets.chomp.to_i

      case choice
      when 1
        create_station
      when 2
        create_train
      when 3
        create_route
      when 4
        manage_route_stations
      when 5
        assign_route_to_train
      when 6
        add_car_to_train
      when 7
        remove_car_from_train
      when 8
        move_train_forward
      when 9
        move_train_backward
      when 10
        display_stations_and_trains
      when 0
        break
      else
        puts "Неверный выбор. Пожалуйста, выберите действие из списка."
      end
    end
  end

  private

  def create_station
    puts "Введите название станции: "
    name = gets.chomp
    @stations << Station.new(name)
    puts "Станция '#{name}' создана."
  end

  def create_train
    begin
      puts "Введите тип поезда: "
      puts "1. Грузовой"
      puts "2. Пассажирский"
      type_train = gets.chomp.to_i

      puts "Введите номер поезда: "
      train_number = gets.chomp

      case type_train
      when 1
        @trains << CargoTrain.new(train_number, 'Грузовой')
      when 2
        @trains << PassengerTrain.new(train_number, 'Пассажирский')
      else
        puts "Введите верный тип поезда"
        return
      end

      puts "Поезд '#{train_number}' создан."
    rescue RuntimeError => e
      puts "Ошибка: #{e.message}"
      retry
    end
  end

  def create_route
    puts "Начальная станция."
    start_station = choise_station

    puts "Конечная станция."
    finish_station = choise_station

    route = Route.new(start_station, finish_station)

    loop do
      puts 'Хотите добавить промежуточную станцию? (yes/no)'
      choise = gets.chomp
      break if choise == 'no'

      puts 'Введите название промежуточной станции: '
      intermediate_station_name = gets.chomp
      intermediate_station = Station.new(intermediate_station_name)
      route.add_station(intermediate_station)
    end

    @routes << route

    route.display_route
  end

  def manage_route_stations
    route = select_route

    loop do
      puts '1. Добавить станцию'
      puts '2. Удалить станцию'
      puts "0. Назад"

      choice = gets.chomp.to_i

      case choice
      when 1
        add_station_to_route(route)
      when 2
        delete_station_to_route(route)
      when 0
        break
      else
        puts 'Неверный выбор.'
      end
    end
  end

  def assign_route_to_train
    train = select_train
    return unless train

    route = select_route
    return unless route

    train.add_route(route)
    puts "Маршрут назначен поезду."
  end

  def add_car_to_train
    train = select_train
    return unless train

    puts "Введите тип вагона: "
    puts "1. Грузовой"
    puts "2. Пассажирский"
    type_cars = gets.chomp.to_i

    puts "Введите номер вагона: "
    number_car = gets.chomp.to_i

    puts "Введите обьем грузового вагона: " if type_cars == 1
    capacity = gets.chomp.to_i

    puts "Введите количество мест пассажирского вагона: " if type_cars == 2
    seats = gets.chomp.to_i

    case type_cars
    when 1
      cargo_car = CargoCars.new(number_car, capacity)
      train.add_cargo_cars_train(cargo_car)
    when 2
      passenger_car = PassengerCars.new(number_car, seats)
      train.add_passenger_cars_train(passenger_car)
    else
      puts "Введите верный тип вагона"
      return
    end

    puts "Вагон добавлен"
  end

  def remove_car_from_train
    train = select_train
    return unless train

    puts "Введите номер вагона для удаления: "
    car_number = gets.chomp.to_i

    car = train.passenger_cars.find { |car| car.number == car_number } if train.is_a?(PassengerTrain)
    car = train.cargo_cars.find { |car| car.number == car_number } if train.is_a?(CargoTrain)

    if car.nil?
      puts "Вагон с номером #{car_number} не найден у поезда #{train.number}."
      return
    end

    train.delete_cars(car)
    puts "Вагон с номером #{car_number} удален у поезда #{train.number}."
  end

  def move_train_forward
    train = select_train
    return unless train

    if train.at_terminal_station? || !train.can_move_forward?
      puts "Поезд находится на конечной станции или у него нет маршрута вперёд"
      return
    end

    train.move_to_next_station
    puts "Поезд перемещен на следующую станцию: #{train.current_station.name}"
  end

  def move_train_backward
    train = select_train
    return unless train

    if train.at_initial_station? || !train.can_move_backward?
      puts "Поезд находится на начальной станции или у него нет маршрута назад"
      return
    end

    train.move_to_previous_station
    puts "Поезд перемещен на предыдущую станцию: #{train.current_station.name}"
  end

  def display_stations_and_trains
    puts "Список станций и поездов на них:"

    @routes.each do |route|
      route.stations.each do |station|
        puts "Станция: #{station.name}"
        puts "Поезда на станции:"
        station.trains.each { |train| display_train_info(train) }
        puts "\n"
      end
    end
  end

  def display_train_info(train)
    puts "  Поезд №#{train.number}, тип: #{train.type}, количество вагонов: #{train.number_of_cars}"
  end

  def select_train
    puts "Выберите поезд:"
    display_trains_list
    index = gets.chomp.to_i - 1
    @trains[index] if index.between?(0, @trains.size - 1)
  end

  def select_route
    puts "Выберите маршрут:"
    display_routes_list
    index = gets.chomp.to_i - 1
    @routes[index] if index.between?(0, @routes.size - 1)
  end

  def display_trains_list
    @trains.each_with_index { |train, index| puts "#{index + 1}. Поезд №#{train.number}" }
  end

  def display_routes_list
    @routes.each_with_index { |route, index| puts "#{index + 1}. #{route.display_route}" }
  end

  def choise_station
    puts "Введите название станции: "
    name = gets.chomp
    station = @stations.find { |s| s.name == name }
    station
  end

  def add_station_to_route(route)
    puts 'Введите станцию для добавления'
    station = choise_station
    return unless station

    route.add_station(station)
    puts "Станция '#{station.name}' добавлена в маршрут."
  end

  def delete_station_to_route(route)
    puts 'Введите станцию для удаления'
    station = choise_station
    return unless station

    route.delete_station(station)
    puts "Станция '#{station.name}' удалена."
  end
end

main = Main.new
main.menu
