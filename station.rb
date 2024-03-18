class Station
  include InstanceCounter
  include Validate
  attr_reader :name, :trains

  @@stations = []

  def self.all
    @@stations
  end

  def initialize(name)
    @name = name
    @trains = []
    @@stations << self
    register_instance
    validate!
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

  private

  def validate!
    raise "Name can't be nill" if name.nil? || name.empty?
    raise "Name must be more than 10 symbols" if name.length > 10
    true
  end
end
