class Bot
  attr_reader :chips, :instructions, :id

  def initialize(id, instructions)
    @instructions = instructions
    @chips = []
    @id = id
  end

  def take_value(value)
    @chips.push(value)
  end

  def give_value(value, dest)
    dest.take_value(value)
    @chips.delete(value)
  end

  def watch_value
    if @chips.index(61) and @chips.index(17)
      puts "bot #{@id} reporting for duty!"
    end
  end

  def grab_value(value)
    @chips.push(value)
  end
end

class Output
  attr_reader :chips

  def initialize
    @chips = []
  end
end


all_instructions = File.readlines('./testcase', chomp: true)
instructions_by_bot = {}
all_instructions.each do |i|
  if matched = i.match(/value (\d+) goes to bot (\d+)/)
    instructions_by_bot[matched[1]].push(['grab_value', foo[2]])
  elsif matched = i.match(/bot (\d+) gives low to (\w+) (\d+) and high to (\w+) (\d+)/)
