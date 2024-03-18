class Route
  include InstanceCounter
  include Validate
  attr_reader :stations

  def initialize(start_station, finish_station)
    @stations = [start_station, finish_station]
    register_instance
    validate!
  end

  def add_station(station)
    stations.insert(-2, station)
  end

  def first_station
    stations.first
  end

  def last_station
    stations.last
  end

  def delete_station(station)
    return if [first_station, last_station].include?(station)

    stations.delete(station)
  end

  def display_route
    puts "Начальная станция: #{first_station.name}"
    stations[1..-2].each { |station| puts "Промежуточная станция: #{station.name}" }
    puts "Конечная станция: #{last_station.name}"
  end

  private

  def validate!
    raise "Name route can't be nill" if start_station.nil? || start_station.empty?
    raise "Name route can't be nill" if finish_station.nil? || finish_station.empty?
    raise "Name route should be at least 2 symbols" if start_station.length < 2
    raise "Name route should be at least 2 symbols" if finish_station.length < 2
    true
  end
end
