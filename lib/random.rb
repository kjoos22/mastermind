class Random
    def self.random_integer(difficulty)

        difficulties = {1 => 3, 2 => 4, 3 => 5}
        url = "https://www.random.org/integers/?num="\
            "#{difficulties[difficulty]}&min=0&max=7&col=4&base=10&"\
            "format=plain&rnd=new"

        response = Net::HTTP.get(URI(url))
        number = []
        for char in response.split("") do
            #reg ex for only numbers?
            if char != "\t" && char != "\n"
                number << char
            end
        end
        number
    end
end