class Station
  attr_reader :trains_station, :name

  def initialize(name)
    @name = name
    @trains_station = []
  end

  def get_train(train)
    @trains_station.push(train)
  end

  def delete_train(train)
    @trains_station.delete(train)
  end

  def show_trains_station
    @trains_station.each do |train|
      puts train
    end
  end

  def show_type_trains
    puts "Статистика по типам поездов на станции #{@name}:"
    type_count = Hash.new(0)
    @trains_station.each do |train|
      type_count[train.type] += 1
    end

    type_count.each do |type, count|
      puts "#{type}: #{count} шт."
    end
  end
end
