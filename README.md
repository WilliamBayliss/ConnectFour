# ConnectFour
A game of ConnectFour for the command line written in Ruby with RSpec

Run in the command line with 'ruby ConnectFour.rb' in the program directory.

The program will prompt each Player for a name and a single unicode character to serve as their marker on the board. Players will, one at a time, enter a number 1-7
to select a column on the board and the program will 'drop' their token into the column, placing it in the lowest empty cell available. When a token has been placed,
the board will scan outwards from that token to see if it is connected to four equal value cells in a straight line, and if so, return a winner and end the game.

If a user selects a column that is full, the game will return an error.
