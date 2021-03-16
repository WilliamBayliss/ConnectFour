require './lib/cell'

describe Cell do
    describe "#initialize" do
        it "sets the column to the first coordinate value" do
            coordinate = [1, 3]
            cell = Cell.new(coordinate)
            expect(cell.coordinate).to eql([1, 3])
        end

        it "initializes value to empty string" do
            coordinate = [0,0]
            cell = Cell.new(coordinate)
            expect(cell.value).to eql(" ")
        end

        it "initializes neighbours to empty array" do
            coordinate = [0,0]
            cell = Cell.new(coordinate)
            expect(cell.neighbours).to eql([])
        end
    end

    describe "#add_edge" do
        it "adds a neighbour to the cell's neighbours array" do
            coordinate_one = [0,0]
            coordinate_two = [0,1]
            cell_one = Cell.new(coordinate_one)
            cell_two = Cell.new(coordinate_two)
            cell_one.add_edge(cell_two)
            expect(cell_one.neighbours[0]).to eql(cell_two)
        end
    end

    describe "#set_value" do
        it "sets the value of a cell to something other than nil" do
            coordinate = [0,0]
            cell = Cell.new(coordinate)
            cell.set_value("test value")
            expect(cell.value).to eql("test value")
        end
    end

    describe "#set_index" do
        it "sets the index of a cell" do
            coordinate = [0,5]
            cell= Cell.new(coordinate)
            cell.set_index(5)
            expect(cell.index).to eql(5)
        end
    end
end