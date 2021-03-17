require './lib/game.rb'

describe Game do
    describe "#initialize" do
        it "initializes" do
            game = Game.new
            expect(game).to_not eql(nil)
        end

        it "initializes @victory attribute to false" do
            game = Game.new
            expect(game.victory).to eql(false)
        end
    end

    describe "#set_victory_true" do
        it "sets @victory attribute to true" do
            game = Game.new
            game.set_victory_true
            expect(game.victory).to eql(true)
        end
    end
    
    describe "#valid_token?" do
        it "returns true if token is single character" do
            game = Game.new
            token = "I"
            expect(game.valid_token?(token)).to eql(true)
        end

        it "returns false if token is longer than 1 character" do
            game = Game.new
            token = "II" 
            expect(game.valid_token?(token)).to eql(false)
        end
    end
    

    describe "#create_board" do
        it "creates board" do
            game = Game.new
            board = game.create_board
            expect(board).to_not eql(nil)
        end

        it "creates board correctly" do
            game = Game.new
            board = game.create_board
            board[[0,5]].set_value("1")
            expect(board[[0,5]].value).to eql("1")
        end

        it "adds neighbours to cells" do
            game = Game.new
            board = game.create_board
            expect(board[[0,0]].neighbours.length).to eql(3)
        end
    end

    describe "#valid_column?" do
        it "returns true is column is single int" do
            game = Game.new
            column = 1
            expect(game.valid_column?(column)).to eql(true)
        end
    end
end