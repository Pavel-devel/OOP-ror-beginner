class Train
  attr_reader :number, :type, :amount_cars, :current_index_station
  attr_accessor :current_station, :next_station

  def initialize(number, type, amount_cars, speed = 0)
    @number = number
    @type = type
    @amount_cars = amount_cars
    @speed = speed
  end

  def go
    @speed += 1
  end

  def self_speed
    @speed
  end

  def stop
    @speed -= 1
    puts 'Поезд остановился' if @speed == 0
  end

  def add_cars_train
    if @speed == 0
      puts 'Вагон успешно добавлен'
      @amount_cars += 1
    else
      puts 'Сначала остановите поезд'
    end
  end

  def delete_cars_train
    if @speed == 0
      puts 'Вагон успешно отцеплен'
      @amount_cars -= 1
    else
      puts 'Сначала остановите поезд'
    end
  end

  def add_route(route)
    @current_index_station = 0
    @route = route
    @current_station = @route.all_station_route[@current_index_station]
    @current_station.get_train(self)
  end

  def move_to_next_station
    if @route
      if @current_index_station < @route.all_station_route.length - 1
        @current_station = @route.all_station_route[@current_index_station]
        @next_station = @route.all_station_route[@current_index_station + 1]

        @current_station.delete_train(self)
        @next_station.get_train(self)

        @current_index_station += 1
      else
        puts 'Поезд находится на конечной станции'
      end
    else
      puts 'Маршрут не назначен'
    end
  end

  def move_to_back_station
    if @current_index_station > 0
      @current_station.delete_train(self)
      @current_index_station -= 1
      @current_station = @route.all_station_route[@current_index_station]
      @current_station.get_train(self)
    else
      puts 'Поезд находится на начальной станции'
    end
  end
end
