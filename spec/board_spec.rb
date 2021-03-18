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

    describe "#get_neighbour_direction" do
        it "returns '-' if cell is to the right" do
            board = Board.new
            array = board.make_board_array()
            board.fill_board_array(array)
            board.create_graph(array)
            board.add_edges_to_graph()
            coordinate_one = [0,0]
            coordinate_two = [0,1]
            cell_one = board[coordinate_one]
            cell_two = board[coordinate_two]
            direction = board.get_neighbour_direction(cell_one, cell_two)
            expect(direction).to eql('-')
        end

        it "returns '-' if cell is to the left" do
            board = Board.new
            array = board.make_board_array()
            board.fill_board_array(array)
            board.create_graph(array)
            board.add_edges_to_graph()
            coordinate_one = [0,1]
            coordinate_two = [0,0]
            cell_one = board[coordinate_one]
            cell_two = board[coordinate_two]
            direction = board.get_neighbour_direction(cell_one, cell_two)
            expect(direction).to eql('-')
        end

        it "returns '|' if cell is above" do
            board = Board.new
            array = board.make_board_array()
            board.fill_board_array(array)
            board.create_graph(array)
            board.add_edges_to_graph()
            coordinate_one = [1,2]
            coordinate_two = [0,2]
            cell_one = board[coordinate_one]
            cell_two = board[coordinate_two]
            direction = board.get_neighbour_direction(cell_one, cell_two)
            expect(direction).to eql('|')
        end

        it "returns '|' if cell is below" do
            board = Board.new
            array = board.make_board_array()
            board.fill_board_array(array)
            board.create_graph(array)
            board.add_edges_to_graph()
            coordinate_one = [1,2]
            coordinate_two = [2,2]
            cell_one = board[coordinate_one]
            cell_two = board[coordinate_two]
            direction = board.get_neighbour_direction(cell_one, cell_two)
            expect(direction).to eql('|')
        end

        it "returns '/' if cell is above right" do
            board = Board.new
            array = board.make_board_array()
            board.fill_board_array(array)
            board.create_graph(array)
            board.add_edges_to_graph()
            coordinate_one = [1,2]
            coordinate_two = [0,3]
            cell_one = board[coordinate_one]
            cell_two = board[coordinate_two]
            direction = board.get_neighbour_direction(cell_one, cell_two)
            expect(direction).to eql('/')
        end

        it "returns '/' if cell is below left" do
            board = Board.new
            array = board.make_board_array()
            board.fill_board_array(array)
            board.create_graph(array)
            board.add_edges_to_graph()
            coordinate_one = [1,2]
            coordinate_two = [2,1]
            cell_one = board[coordinate_one]
            cell_two = board[coordinate_two]
            direction = board.get_neighbour_direction(cell_one, cell_two)
            expect(direction).to eql('/')
        end

        it "returns '\\' if cell is below right" do
            board = Board.new
            array = board.make_board_array()
            board.fill_board_array(array)
            board.create_graph(array)
            board.add_edges_to_graph()
            coordinate_one = [1,2]
            coordinate_two = [2,3]
            cell_one = board[coordinate_one]
            cell_two = board[coordinate_two]
            direction = board.get_neighbour_direction(cell_one, cell_two)
            expect(direction).to eql('\\')
        end
        it "returns '\\' if cell is above left" do
            board = Board.new
            array = board.make_board_array()
            board.fill_board_array(array)
            board.create_graph(array)
            board.add_edges_to_graph()
            coordinate_one = [1,2]
            coordinate_two = [0,1]
            cell_one = board[coordinate_one]
            cell_two = board[coordinate_two]
            direction = board.get_neighbour_direction(cell_one, cell_two)
            expect(direction).to eql('\\')
        end
    end

    describe "#directional_scan" do
        it "returns an array of horizontal cells with same value" do
            board = Board.new
            array = board.make_board_array()
            board.fill_board_array(array)
            board.create_graph(array)
            board.add_edges_to_graph()
            
            board[[1,0]].set_value("1")
            cell = board[[1,0]]
            board[[1,1]].set_value("1")
            board[[1,2]].set_value("1")
            board[[1,3]].set_value("1")
            direction = '-'
            in_a_row = board.directional_scan(direction, cell)
            expect(in_a_row[-1]).to eql(board[[1,3]])
        end

        it "returns array of vertical cells with same value" do
            board = Board.new
            array = board.make_board_array()
            board.fill_board_array(array)
            board.create_graph(array)
            board.add_edges_to_graph()

            board[[1,0]].set_value(1)
            cell = board[[1,0]]
            board[[2,0]].set_value(1)
            board[[3,0]].set_value(1)
            board[[4,0]].set_value(1)
            direction = '|'
            in_a_row = board.directional_scan(direction, cell)
            expect(in_a_row[-1]).to eql(board[[4,0]])
        end

        it "returns an array of \\ cells with the same value" do
            board = Board.new
            array = board.make_board_array()
            board.fill_board_array(array)
            board.create_graph(array)
            board.add_edges_to_graph()

            board[[1,0]].set_value(1)
            cell = board[[1,0]]
            board[[2,1]].set_value(1)
            board[[3,2]].set_value(1)
            board[[4,3]].set_value(1)
            direction = '\\'
            in_a_row = board.directional_scan(direction, cell)
            expect(in_a_row[-1]).to eql(board[[4,3]])
        end

        it "returns an array of / cells with the same value" do
            board = Board.new
            array = board.make_board_array()
            board.fill_board_array(array)
            board.create_graph(array)
            board.add_edges_to_graph()

            board[[5,0]].set_value(1)
            cell = board[[5,0]]
            board[[4,1]].set_value(1)
            board[[3,2]].set_value(1)
            board[[2,3]].set_value(1)
            direction = '/'
            in_a_row = board.directional_scan(direction, cell)
            expect(in_a_row[-1]).to eql(board[[2,3]])
        end

        it "returns an array of fewer than four same value cells if no other same value cells in that direction" do
            board = Board.new
            array = board.make_board_array()
            board.fill_board_array(array)
            board.create_graph(array)
            board.add_edges_to_graph()

            board[[1,0]].set_value(1)
            cell = board[[1,0]]
            board[[1,1]].set_value(1)
            board[[1,2]].set_value(1)
            direction = '-'
            in_a_row = board.directional_scan(direction, cell)
            expect(in_a_row.length).to eql(3)
        end

        it "returns only the cells in a given direction with the same value" do
            board = Board.new
            array = board.make_board_array()
            board.fill_board_array(array)
            board.create_graph(array)
            board.add_edges_to_graph()


            cell = board[[1,0]]
            board[[1,0]].set_value(1)
            board[[1,1]].set_value(1)
            board[[0,0]].set_value(1)
            board[[0,1]].set_value(1)
            board[[1,1]].set_value(1)
            board[[1,2]].set_value(1)
            board[[1,3]].set_value(1)
            board[[2,2]].set_value(1)
            board[[2,3]].set_value(1)
            in_a_row = board.directional_scan('-', cell)
            expect(in_a_row[-1]).to eql(board[[1,3]])
            expect(in_a_row.length).to eql(4)
        end

        it "does not skip over cells that do not match source value" do
            board = Board.new
            array = board.make_board_array()
            board.fill_board_array(array)
            board.create_graph(array)
            board.add_edges_to_graph()


            cell = board[[1,0]]
            board[[1,0]].set_value(1)
            board[[1,1]].set_value(1)
            board[[1,3]].set_value(0)
            board[[1,4]].set_value(1)
            in_a_row = board.directional_scan('-', cell)
            expect(in_a_row.length).to eql(2)
        end
    end

    describe "#win_condition?" do
        it "returns false if there is no win condition in a row from a given cell" do
            board = Board.new
            array = board.make_board_array()
            board.fill_board_array(array)
            board.create_graph(array)
            board.add_edges_to_graph()


            cell = board[[1,0]]
            board[[1,0]].set_value(1)
            board[[1,1]].set_value(0)
            board[[0,0]].set_value(1)
            board[[0,1]].set_value(0)
            board[[1,1]].set_value(2)
            board[[1,2]].set_value(3)
            board[[1,3]].set_value(4)
            board[[2,2]].set_value(5)
            board[[2,3]].set_value(1)
            expect(board.win_condition?(cell)).to eql(false)
        
        end

        it "returns true if there is a win condition in a row from a given cell" do
            board = Board.new
            array = board.make_board_array()
            board.fill_board_array(array)
            board.create_graph(array)
            board.add_edges_to_graph()


            cell = board[[1,0]]
            board[[1,0]].set_value(1)
            board[[1,1]].set_value(7)
            board[[0,0]].set_value(2)
            board[[0,1]].set_value(3)
            board[[1,1]].set_value(1)
            board[[1,2]].set_value(1)
            board[[1,3]].set_value(1)
            board[[2,2]].set_value(5)
            board[[2,3]].set_value(1)
            expect(board.win_condition?(cell)).to eql(true)
        end
    end

    describe "#get_column" do
        it "returns array of cells in a given column of correct length" do
            board = Board.new
            array = board.make_board_array()
            board.fill_board_array(array)
            board.create_graph(array)
            board.add_edges_to_graph()

            column = 3
            cells = board.get_column(3)
            expect(cells.length).to eql(6)
        end

        it "returns cells in reverse order, lowest cell on the board first" do
            board = Board.new
            array = board.make_board_array()
            board.fill_board_array(array)
            board.create_graph(array)
            board.add_edges_to_graph()

            column = 3
            cells = board.get_column(3)
            expect(cells[0]).to eql(board[[5,3]])
        end

    end

    describe "#token_drop" do
        it "inserts a player's token into the lowest available cell in a given column" do
            board = Board.new
            array = board.make_board_array()
            board.fill_board_array(array)
            board.create_graph(array)
            board.add_edges_to_graph()

            token = "1"
            column = 3
            board.token_drop(column, token)
            expect(board[[5,3]].value).to eql(token)
        end

        it "only modifies the lowest empty cell in a column" do
            board = Board.new
            array = board.make_board_array()
            board.fill_board_array(array)
            board.create_graph(array)
            board.add_edges_to_graph()

            token = "1"
            column = 3
            board[[5,3]].set_value("2")
            board[[4,3]].set_value("2")
            board[[3,3]].set_value("2")
            board.token_drop(column, token)
            expect(board[[5,3]].value).to_not eql(token)
        end

        it "doesn't modify cells higher than the lowest available cell" do
            board = Board.new
            array = board.make_board_array()
            board.fill_board_array(array)
            board.create_graph(array)
            board.add_edges_to_graph()

            token = "1"
            column = 3
            board.token_drop(column, token)
            expect(board[[4,3]]).to_not eql(token)
        end

        it "returns the modified cell" do
            board = Board.new
            array = board.make_board_array()
            board.fill_board_array(array)
            board.create_graph(array)
            board.add_edges_to_graph()

            token = "1"
            column = 3
            cell = board.token_drop(column, token)
            expect(cell).to_not eql(board[[4,3]])       
        end
    end

    describe "#column_full?" do
        it "returns false if the column is not full" do
            board = Board.new
            array = board.make_board_array()
            board.fill_board_array(array)
            board.create_graph(array)
            board.add_edges_to_graph()
            
            column = 3
            expect(board.column_full?(column)).to eql(false)
        end

        it "returns true if top cell in that column has a value != initialized value" do
            board = Board.new
            array = board.make_board_array()
            board.fill_board_array(array)
            board.create_graph(array)
            board.add_edges_to_graph()
            column = 3
            board[[0,3]].set_value("X")
            board[[1,3]].set_value("X")
            board[[2,3]].set_value("X")
            board[[3,3]].set_value("X")
            board[[4,3]].set_value("X")
            board[[5,3]].set_value("X")

            expect(board.column_full?(column)).to eql(true)
        end

    end

end

