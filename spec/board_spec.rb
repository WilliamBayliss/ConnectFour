require './lib/board.rb'
require './lib/cell.rb'

describe Board do
    describe "#initialize" do
        it "initializes" do
            board = Board.new
            expect(board).to_not eql(nil)
        end
    end

    describe "#add_cell" do 
        it "adds a cell to the board" do
            board = Board.new
            coordinate = [1, 5]
            cell = Cell.new(coordinate)
            board.add_cell(cell)
            expect(board[coordinate]).to eql(cell)
        end
    end

    describe "#[]" do
        it "gets the cell at the given coordinate" do
            board = Board.new
            coordinate = [1, 5]
            cell = Cell.new(coordinate)
            board.add_cell(cell)
            expect(board[coordinate]).to eql(cell)
        end
    end

    describe "#make_board_array" do
        it "Creates an array of 6 arrays" do
            board = Board.new
            array = board.make_board_array()
            expect(array.length).to eql(6)
        end
    end

    describe "#fill_board_array" do
        it "fills the board array with cells" do
            board = Board.new
            array = board.make_board_array()
            board.fill_board_array(array)
            coordinate = [1,5]
            test_cell = Cell.new(coordinate)
            expect(array[1][5].coordinate).to eql(test_cell.coordinate)
        end
    end

    describe "#add_indices" do 
        it "adds the correct index to each cell" do
            board = Board.new
            array = board.make_board_array()
            board.fill_board_array(array)
            board.create_graph(array)
            board.add_indices()
            expect(board[[5,6]].index).to eql(41)
        end
    end

    describe "#create_graph" do
        it "adds all cells to the @board" do
            board = Board.new
            array = board.make_board_array()
            board.fill_board_array(array)
            board.create_graph(array)
            coordinate = [1,5]
            expect(board[coordinate]).to_not eql(nil)
        end
    end

    describe "#adjacent?" do
        it "returns false if cell is self" do
            board = Board.new
            array = board.make_board_array()
            board.fill_board_array(array)
            board.create_graph(array)
            coordinate_one = [0,0]
            coordinate_two = [0,0]
            cell_one = Cell.new(coordinate_one)
            cell_two = Cell.new(coordinate_two)
            result = board.adjacent?(cell_one, cell_two)
            expect(result).to eql(false)
        end
        it "returns false if cell is not adjacent" do
            board = Board.new
            array = board.make_board_array()
            board.fill_board_array(array)
            board.create_graph(array)
            coordinate_one = [0,0]
            coordinate_two = [2,0]
            cell_one = Cell.new(coordinate_one)
            cell_two = Cell.new(coordinate_two)
            result = board.adjacent?(cell_one, cell_two)
            expect(result).to eql(false)
        end
        it "returns true if cell is to the right" do
            board = Board.new
            array = board.make_board_array()
            board.fill_board_array(array)
            board.create_graph(array)
            result = board.adjacent?(board[[0,1]], board[[0,2]])
            expect(result).to eql(true)
        end
        it "returns true if cell is to the left" do
            board = Board.new
            array = board.make_board_array()
            board.fill_board_array(array)
            board.create_graph(array)
            result = board.adjacent?(board[[0,2]], board[[0,1]])
            expect(result).to eql(true)
        end
        it "returns true if cell is above" do
            board = Board.new
            array = board.make_board_array()
            board.fill_board_array(array)
            board.create_graph(array)
            result = board.adjacent?(board[[2,1]], board[[1,1]])
            expect(result).to eql(true)
        end
        it "returns true if cell is below" do
            board = Board.new
            array = board.make_board_array()
            board.fill_board_array(array)
            board.create_graph(array)
            result = board.adjacent?(board[[0,1]], board[[1,1]])
            expect(result).to eql(true)
        end
        it "returns true if cell is above and to the right" do
            board = Board.new
            array = board.make_board_array()
            board.fill_board_array(array)
            board.create_graph(array)
            result = board.adjacent?(board[[3,3]], board[[2,4]])
            expect(result).to eql(true)
        end
        it "returns true if cell is above and to the left" do
            board = Board.new
            array = board.make_board_array()
            board.fill_board_array(array)
            board.create_graph(array)
            result = board.adjacent?(board[[3,3]], board[[2,2]])
            expect(result).to eql(true)
        end
        it "returns true if cell is below and to the right" do
            board = Board.new
            array = board.make_board_array()
            board.fill_board_array(array)
            board.create_graph(array)
            result = board.adjacent?(board[[0,1]], board[[1,2]])
            expect(result).to eql(true)
        end
        it "returns true if cell is below and to the left" do
            board = Board.new
            array = board.make_board_array()
            board.fill_board_array(array)
            board.create_graph(array)
            result = board.adjacent?(board[[2,3]], board[[3,2]])
            expect(result).to eql(true)
        end
    end

    describe "#add_edge" do
        it "adds a square to another square's neighbours list" do
            board = Board.new
            array = board.make_board_array()
            board.fill_board_array(array)
            board.create_graph(array)
            coordinate_one = [0,1]
            coordinate_two = [1,1]
            board.add_edge(board[coordinate_one], board[coordinate_two])
            expect(board[coordinate_one].neighbours[0]).to eql(board[coordinate_two])
        end
    end

    describe "#add_edges_to_graph" do
        it "adds a cell's adjacent cells to cell's neighbours list" do
            board = Board.new
            array = board.make_board_array()
            board.fill_board_array(array)
            board.create_graph(array)

            board.add_edges_to_graph()
            coordinate = [0,0]
            cell = board[coordinate]
            neighb_1 = board[[0,1]]
            neighbours = cell.neighbours
            expect(neighbours[0]).to eql(neighb_1)
        end

        it "correctly adds all of a cell's neighbours" do
            board = Board.new
            array = board.make_board_array()
            board.fill_board_array(array)
            board.create_graph(array)
            board.add_edges_to_graph()
            
            neighbours = board[[3,3]].neighbours
            neighbours_list = [board[[2,2]], board[[2,3]], board[[2,4]], 
                               board[[3,2]],               board[[3,4]],
                               board[[4,2]], board[[4,3]], board[[4,4]],]

            expect(neighbours).to eql(neighbours_list)
        end
        
    end

    

end

