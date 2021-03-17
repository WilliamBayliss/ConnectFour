class Game
    attr_accessor :victory
    def initialize
        @victory = false

    end

    def set_victory_true
        @victory = true
    end

    def launch
        prelude
        @player_one = create_player("One")
        @player_two = create_player("Two")
        if @player_one.token == @player_two.token
            puts "#{@player_two.name}, please pick a different token than #{@player_one.name}"
            @player_two = create_player("Two")
        end
        @board = create_board()

        until @victory == true
            run_game()
        end

    end

    def run_game
        player_turn(@player_one)

        player_turn(@player_two)
    end

    def victory!(player)
        puts "Four in a row! #{player.name} you win!"
        set_victory_true()
        exit()
    end

    def player_turn player
        @board.print_board()
        puts "#{player.name}, it is your turn!"
        column = get_column()
        selected_cell = @board.token_drop(column, player.token)
        p player.token
        if @board.win_condition?(selected_cell)
            victory!(player)
        else
            return
        end
    end

    def get_player_info player_number
        puts "Player #{player_number}, what is your name?"
        name = gets.chomp
        return name
    end


    def create_player player_number
        name = get_player_info(player_number)
        player = Player.new(name)
        token = get_player_token(player_number)
        player.set_token(token)
        return player
    end

    def get_player_token player_number
        token = get_player_token_input(player_number)
        until valid_token?(token)
            token = get_player_token_input(player_number)
        end
        token
    end

    def get_player_token_input player_number
        puts "Player #{player_number}, please enter a single unicode character that will be your marker on the board"
        token = gets.chomp
        return token
    end

    def valid_token? token
        if token.length > 1 || token.length < 0
            puts "Invalid input."
            return false
        else
            return true
        end
    end

    def create_board
        board = Board.new
        array = board.make_board_array
        board.fill_board_array(array)
        board.create_graph(array)
        board.add_edges_to_graph
        board
    end

    def get_column
        column = get_column_input()
        until valid_column?(column)
            column = get_column_input()
        end

        column -= 1
    end

    def get_column_input
        puts "Please enter a single digit between 1 and 7 to select your column"
        column = gets.chomp
        column.to_i
    end


    def valid_column? column
        if column.to_s.length > 1
            puts "Invalid input."
            return false
        elsif column < 1 || column > 8
            puts "Invalid input."
            return false
        else
            return true
        end
        

    end

    def prelude
        puts "Welcome to Connect Four!"
        puts "In this game you will play against one other player, taking turns dropping your tokens into columns on a board."
        puts "The objective is to get four of your tokens in a direct line to win!"
    end
end