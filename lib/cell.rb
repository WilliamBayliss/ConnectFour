class  Cell
    attr_accessor :coordinate, :value, :neighbours
  def initialize coordinate
    @coordinate = coordinate
    @value = nil
    @neighbours = []
  end

  def add_edge cell
    @neighbours << cell
  end

  def set_value value
    @value = value
  end
end