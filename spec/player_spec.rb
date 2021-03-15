require "./lib/player.rb"

describe Player do
    describe "#initialize" do
        it "initializes" do
            name = "John"
            player = Player.new(name)
            expect(player).to_not eql(nil)
        end
        it "initializes with a name" do
            name = "John"
            player = Player.new(name)
            expect(player.name).to eql("John")
        end
        it "initializes with a nil player token" do
            name = "john"
            player = Player.new(name)
            expect(player.token).to eql(nil)
        end
    end

    describe "#set_token" do 
        it "sets the player's token" do
            name = "john"
            token = "K"
            player = Player.new(name)
            player.set_token(token)
            expect(player.token).to eql("K")
        end
    end

end