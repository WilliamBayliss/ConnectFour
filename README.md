# ConnectFour
A game of ConnectFour for the command line written in Ruby with RSpec

Run in the command line with 'ruby ConnectFour.rb' in the program directory.

The program will prompt each Player for a name and a single unicode character to serve as their marker on the board. Players will, one at a time, enter a number 1-7
to select a column on the board and the program will 'drop' their token into the column, placing it in the lowest empty cell available. When a token has been placed,
the board will scan outwards from that token to see if it is connected to four equal value cells in a straight line, and if so, return a winner and end the game.

My first project where I've worked with RSpec and TDD, and gained some experience working with a Graph structure. The algorithm that checks for a Four-in-a-row is a kind of BFS that will get an array of arrays that contain every same-value cell in a direction, and then return that array. So if the array is three indexes long, there are three same-value cells in a straight line. This way if there are many adjacent same-value cells but they do not form a straight line they will not be counted. If it encounters a different-cell value it will stop scanning that direction.
