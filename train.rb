class Train
  include Validate
  include Manufacturer
  include InstanceCounter
  attr_reader :route
  attr_accessor :current_station_index, :number

  NUMBER_FORMAT = /^[a-z\d]{3}-?[a-z\d]{2}$/i

  @@trains = []

  def self.find(number)
    @@trains.find { |train| train.number == number }
  end

  def initialize(number, _carriages)
    @number = number
    @speed = 0
    @@trains << self
    register_instance
    validate!
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
    return unless next_station

    current_station.delete_train(self)
    @current_station_index += 1
    current_station.get_train(self)
  end

  def move_to_previous_station
    return unless previous_station

    current_station.delete_train(self)
    @current_station_index -= 1
    current_station.get_train(self)
  end

  def at_terminal_station?
    current_station_index == route.stations.length - 1
  end

  def can_move_forward?
    current_station_index < route.stations.length - 1
  end

  def at_initial_station?
    current_station_index == 0
  end

  def can_move_backward?
    current_station_index > 0
  end

  # Эти методы не должны быть доступны в интерфейсе
  private

  def next_station
    route.stations[@current_station_index + 1]
  end

  def previous_station
    route.stations[@current_station_index - 1] if @current_station_index.positive?
  end

  def validate!
    raise "Number can't be nill" if number.nil? || number.empty?
    raise "Number should be at least 6 symbols" if number.length < 6
    raise "Number has invalid format" if number !~ NUMBER_FORMAT
    true
  end
end
