class Reputation
  def self.calculate(object)
    sleep(5)
    File.open('text.txt', 'w') {|f |
      f.puts '1'
    }
  end
end