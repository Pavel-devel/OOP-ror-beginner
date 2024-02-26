class Route
  attr_reader :stations

  def initialize(start_station, finish_station)
    @stations = [start_station, finish_station]
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
end
