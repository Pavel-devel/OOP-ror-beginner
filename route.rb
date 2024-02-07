class Route
  attr_reader :start_station, :finish_station, :intermediate_stations

  def initialize(finish_station, start_station)
    @start_station = start_station
    @finish_station = finish_station
    @intermediate_stations = []
  end

  def add_intermediate_stations(station)
    @intermediate_stations << station
  end

  def delete_intermediate_stations(station)
    @intermediate_stations.delete(station)
  end

  def all_station_route
    stations = [@start_station]
    stations.concat(@intermediate_stations)
    stations << @finish_station
    stations
  end

  def display_route
    puts "Начальная станция: #{@start_station.name}"

    @intermediate_stations.each do |station|
      puts "Промежуточная станция: #{station.name}"
    end

    puts "Конечная станция: #{@finish_station.name}"
  end
end
