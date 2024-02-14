class Train
  require_relative 'passenger_train'
  require_relative 'cargo_train'

  attr_reader :route
  attr_accessor :current_station_index, :number

  def initialize(number, _carriages)
    @number = number
    @speed = 0
  end

  def go
    @speed += 1
  end

  def stop
    @speed -= 1
    puts 'Поезд остановился' if @speed == 0
  end

  def add_route(route)
    @current_station_index = 0
    @route = route
    @route.stations[@current_station_index].get_train(self)
  end

  def current_station
    route.stations[@current_station_index]
  end

  def move_to_next_station
    @current_station_index += 1 if next_station
  end

  def move_to_previous_station
    @current_station_index -= 1 if previous_station
  end

  # Эти методы не должны быть доступны в интерфейсе
  private

  def next_station
    route.stations[@current_station_index + 1]
  end

  def previous_station
    route.stations[@current_station_index - 1] if @current_station_index.positive?
  end
end
