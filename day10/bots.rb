require 'pry'
binding.pry

class Bot
  attr_reader :chips, :id

  def initialize(id)
    @chips = []
    @id = id
  end

  def take_value(value)
    @chips.push(value)
    watch_value
  end

  def give_value(value, dest)
    dest.take_value(value)
    @chips.delete(value)
  end

  def watch_value
    if @chips.index(2) and @chips.index(5)
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

  def take_value(value)
    @chips.push(value)
  end
end


all_instructions = File.readlines('./testcase', chomp: true).sort.reverse
last_grab = all_instructions.index { |i| i.match(/^bot.*/) }
bots = {}
outputs = {}
all_instructions[0,last_grab].each do |i|
  parts = i.split
  value, bot = parts[1], parts[5]
  if bots[bot] == nil
    bots[bot] = Bot.new(bot)
  end
  bots[bot].grab_value(value)
end

all_instructions = all_instructions[last_grab..-1]
while all_instructions.length > 0
  all_instructions.each do |i|
    parts = i.match(/bot (\d+) gives low to (\w+) (\d+) and high to (\w+) (\d+)/)
    bot = parts[1]
    low_dest_type = parts[2]
    low_dest = parts[3]
    high_dest_type = parts[4]
    high_dest = parts[5]
    next if bots[bot].chips.length < 2
    if low_dest_type == 'output'
      if outputs[low_dest] == nil
        outputs[low_dest] = Output.new
      end
      bots[bot].give_value(bots[bot].chips.min,outputs[low_dest])
    else
      if bots[low_dest] == nil
        bots[low_dest] = Bot.new(low_dest)
      end
      bots[bot].give_value(bots[bot].chips.min,bots[low_dest])
    end
    if high_dest_type == 'output'
      if outputs[high_dest] == nil
        outputs[high_dest] = Output.new
      end
      bots[bot].give_value(bots[bot].chips.max,outputs[high_dest])
    else
      if bots[high_dest] == nil
        bots[high_dest] = Bot.new(high_dest)
      end
      bots[bot].give_value(bots[bot].chips.max,bots[high_dest])
    end
    all_instructions.delete(parts[0])
  end
end
