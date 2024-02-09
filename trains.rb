class Train
  attr_reader :number, :type, :amount_cars, :route
  attr_accessor :current_station_index

  def initialize(number, type, amount_cars, speed = 0)
    @number = number
    @type = type
    @amount_cars = amount_cars
    @speed = speed
  end

  def go
    @speed += 1
  end

  def stop
    @speed -= 1
    puts 'Поезд остановился' if @speed == 0
  end

  def add_cars_train
    return puts 'Сначала остановите поезд' if @speed != 0

    puts 'Вагон успешно добавлен'
    @amount_cars += 1
  end

  def delete_cars_train
    return puts 'Сначала остановите поезд' if @speed != 0

    puts 'Вагон успешно отцеплен'
    @amount_cars -= 1
  end

  def add_route(route)
    @current_station_index = 0
    @route = route
    @route.stations[@current_station_index].get_train(self)
  end

  def current_station
    route.stations[@current_station_index]
  end

  def next_station
    route.stations[@current_station_index + 1]
  end

  def previous_station
    route.stations[@current_station_index - 1] if @current_station_index > 0
  end

  def move_to_next_station
    @current_station_index += 1 if next_station
  end

  def move_to_previous_station
    @current_station_index -= 1 if previous_station
  end
end
