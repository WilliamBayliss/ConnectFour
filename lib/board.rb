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

    def create_board board_array

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

    def create_graph board_array
        board_array.each do |sub_array|
            sub_array.each do |cell|
                add_cell(cell)
            end
        end
    end

    def add_edges_to_graph
        @board.each do |cell|
            @board.each do |other_cell|
                if adjacent?(cell, other_cell)
                    add_edge(cell, other_cell)
                end
            end
        end
    end

    def adjacent? cell_one, cell_two
        x_difference = cell_one.coordinate[0] - cell_two.coordinate[0]
        y_difference = cell_two.coordinate[1] - cell_two.coordinate[1]
        if ( x_difference <= 1 && x_difference >= -1) && (y_difference <= 1 && y_difference >= -1)
            return true
        else
            return false
        end
    end
end