class Station
  attr_reader :name, :trains

  def initialize(name)
    @name = name
    @trains = []
  end

  def get_train(train)
    trains << train
  end

  def delete_train(train)
    trains.delete(train)
  end

  def show_type_trains
    puts "Статистика по типам поездов на станции #{@name}:"
    type_count = Hash.new(0)

    @trains.each { |train| type_count[train.type] += 1 }

    type_count.each { |type, count| puts "#{type}: #{count} шт." }
  end
end
