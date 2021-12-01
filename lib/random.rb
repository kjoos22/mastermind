class Random
    def self.random_integer
        url = "https://www.random.org/integers/?num=4&min=0&max=7&col=4&base=10&format=plain&rnd=new"

        response = Net::HTTP.get(URI(url))
        number = []
        for char in response.split("") do
            if char != "\t" && char != "\n"
                number << char
            end
        end
        number
    end
end