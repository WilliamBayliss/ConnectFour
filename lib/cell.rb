class  Cell
    attr_accessor :coordinate, :value, :neighbours
  def initialize coordinate
    @index = 0
    @coordinate = coordinate
    @value = " "
    @neighbours = []
  end

  def add_edge cell
    @neighbours << cell
  end

  def set_value value
    @value = value
  end
end