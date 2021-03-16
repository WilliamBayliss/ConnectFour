class Board
    def initialize
        @board = {}
    end

    def [](coordinate)
        @board[coordinate]
    end

    def add_cell cell
        @board[cell.coordinate] = cell
    end

    def add_edge cell, neighbour
        @board[cell.coordinate].add_edge(neighbour)
    end

    def make_board_array
        array = []
        6.times do
            array.append([])
        end
        array
    end

    def fill_board_array board_array
        board_array.each_with_index do |sub_array, x_index|
            y_index = 0
            7.times do
                coordinate = [x_index,y_index]
                new_cell = Cell.new(coordinate)
                sub_array.append(new_cell)
                y_index += 1
            end
        end

    end

    def add_indices
        @board.each_with_index do |(key, value), index|
            @board[key].set_index(index)
        end
    end

    def create_graph board_array
        board_array.each do |sub_array|
            sub_array.each do |cell|
                add_cell(cell)
            end
        end
    end

    def add_edges_to_graph
        @board.each do |coordinate, cell|
            @board.each do |other_coordinate, other_cell|
                if adjacent?(@board[coordinate], @board[other_coordinate])
                    add_edge(@board[coordinate], @board[other_coordinate])
                end
            end
        end
    end

    def adjacent? cell_one, cell_two
        x_difference = cell_one.coordinate[0] - cell_two.coordinate[0]
        y_difference = cell_one.coordinate[1] - cell_two.coordinate[1]
        if x_difference == 0 && y_difference == 0
            return false
        elsif ( x_difference <= 1 && x_difference >= -1) && (y_difference <= 1 && y_difference >= -1)
            return true
        else
            return false
        end
    end

    def do_setup
        array = make_board_array()
        fill_board_array(array)
        create_graph(array)
        add_edges_to_graph()
        add_indices()
    end


    def print_board
        puts "[ #{@board[[0,0]].value} | #{@board[[0,1]].value} | #{@board[[0,2]].value} | #{@board[[0,3]].value} | #{@board[[0,4]].value} | #{@board[[0,5]].value} | #{@board[[0,6]].value} ]"
        puts "[ #{@board[[1,0]].value} | #{@board[[1,1]].value} | #{@board[[1,2]].value} | #{@board[[1,3]].value} | #{@board[[1,4]].value} | #{@board[[1,5]].value} | #{@board[[1,6]].value} ]"
        puts "[ #{@board[[2,0]].value} | #{@board[[2,1]].value} | #{@board[[2,2]].value} | #{@board[[2,3]].value} | #{@board[[2,4]].value} | #{@board[[2,5]].value} | #{@board[[2,6]].value} ]"
        puts "[ #{@board[[3,0]].value} | #{@board[[3,1]].value} | #{@board[[3,2]].value} | #{@board[[3,3]].value} | #{@board[[3,4]].value} | #{@board[[3,5]].value} | #{@board[[3,6]].value} ]"
        puts "[ #{@board[[4,0]].value} | #{@board[[4,1]].value} | #{@board[[4,2]].value} | #{@board[[4,3]].value} | #{@board[[4,4]].value} | #{@board[[4,5]].value} | #{@board[[4,6]].value} ]"
        puts "[ #{@board[[5,0]].value} | #{@board[[5,1]].value} | #{@board[[5,2]].value} | #{@board[[5,3]].value} | #{@board[[5,4]].value} | #{@board[[5,5]].value} | #{@board[[5,6]].value} ]"
    end
end