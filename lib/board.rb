require_relative 'cell.rb'
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

    # Creates an array of 6 empty sub arrays
    def make_board_array
        array = []
        6.times do
            array.append([])
        end
        array
    end

    # Fills a 2d array with cells created based on the x_index, the index of each sub_array
    # and y_index, a value that increases by 1 7 times to represent the index in the sub_array
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

    # Iterates through filled board array and creates a graph with the cells
    def create_graph board_array
        board_array.each do |sub_array|
            sub_array.each do |cell|
                add_cell(cell)
            end
        end
    end

    # Checks if cells on the board are neighbours, and if so adds an edge between the vertices on the graph
    def add_edges_to_graph
        @board.each do |coordinate, cell|
            @board.each do |other_coordinate, other_cell|
                if adjacent?(@board[coordinate], @board[other_coordinate])
                    add_edge(@board[coordinate], @board[other_coordinate])
                end
            end
        end
    end

    # Determines if two cells are neighbours by determining the difference between the x an y coordinates of both cells
    # If the difference of both coordinates is 0 the cells are the same and it returns false
    # Otherwise if the difference between either sets of x and y coordinates is 1 or -1 the cells are neighbours and it returns true
    # any other difference values it returns false
    def adjacent? cell_one, cell_two
        x_difference = cell_one.coordinate[0] - cell_two.coordinate[0]
        y_difference = cell_one.coordinate[1] - cell_two.coordinate[1]
        if x_difference == 0 && y_difference == 0
            return false
        elsif (x_difference <= 1 && x_difference >= -1) && (y_difference <= 1 && y_difference >= -1)
            return true
        else
            return false
        end
    end

    # Returns either '-', '|', '\', or '/' to represent the direction of a cell's neighbour
    # It does this by evaluating the x and y coordinates of two cells, assuming that it won't be
    # called on two cells that aren't neighbours
    # If cells have the same x coordinate they are horizontal neighbours
    # If cells have the same y coordinate they are vertical neighbours
    # Diagonal relationships are evaluated by conditionals narrowing down whether the cell is
    # above or below, and then to the left or to the right of the source cell
    # i.e cell.coordinate[1,5] is above and to the left of cell.coordinate[0,4] because both values are smaller
    def get_neighbour_direction cell_one, cell_two
        if cell_one.coordinate[0] == cell_two.coordinate[0]
            direction = '-'
        elsif cell_one.coordinate[1] == cell_two.coordinate[1]
            direction = '|'
        elsif cell_two.coordinate[0] < cell_one.coordinate[0]
            if cell_two.coordinate[1] < cell_one.coordinate[1]
                direction = '\\'
            elsif cell_two.coordinate[1] > cell_one.coordinate[1]
                direction = '/'
            end
        elsif cell_two.coordinate[0] > cell_one.coordinate[0]
            if cell_two.coordinate[1] < cell_one.coordinate[1]
                direction = '/'
            elsif cell_two.coordinate[1] > cell_one.coordinate[1]
                direction = '\\'
            end
        end
        direction
    end

    # Looks at all a cell's neighbours and gets the direction of a neighbour,
    # then scans that direction for a win condition and returns true if found
    def win_condition? cell
        cell.neighbours.each do |neighbour|
            if neighbour.value == cell.value
                direction = get_neighbour_direction(cell, neighbour)
                in_a_row = directional_scan(direction, cell)

                return true if in_a_row.length >= 4
            end
        end
        false

    end

    # Will scan unvisited cell neighbours in a direction for cells with matching values in a straight line
    # and return the array
    def directional_scan direction, cell
        in_a_row = []
        queue = []
        queue.append(cell)
        token = cell.value

        while queue.length() > 0
            temp = queue[0]
            queue.shift
            temp.neighbours.each do |neighbour|
                unless in_a_row.include? neighbour
                    if get_neighbour_direction(temp, neighbour) == direction
                        if neighbour.value == token
                            queue.append(neighbour)
                            in_a_row.append(neighbour)
                        end
                    end
                end
            end
        end
        in_a_row
    end

    # Gets column from get_column and iterates through it until it finds empty cell
    # Then modifies that cell on the @board
    def token_drop column_index, token
        column = get_column(column_index)

        column.each do |cell|
            if cell.value == " "
                @board[cell.coordinate].set_value(token)
                return @board[cell.coordinate]
            end
        end
    end

    # Gets all the cells with the same y value and returns a reversed array of those cells
    def get_column column
        cell_list = []
        @board.each do |(coordinate, cell)|
            if coordinate[1] == column
                cell_list.append(cell)
            end
        end
        cell_list.reverse!
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
