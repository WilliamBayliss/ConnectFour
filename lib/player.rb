class Player
    attr_reader :name
    attr_accessor :token
    def initialize name
        @name = name
        @token = nil
    end

    def set_token token
        @token = token
    end
end