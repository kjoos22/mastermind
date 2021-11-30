class Random
    def self.random_integer
        url = "https://www.random.org/integers/?num=4&min=0&max=7&col=1&base=10&format=plain&rnd=new"

        response = Net::HTTP.get(URI(url))
    end
end