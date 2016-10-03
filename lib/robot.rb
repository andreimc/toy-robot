require_relative 'table'
require_relative 'position'
require_relative 'commands/turn_command'

class Robot
  FACINGS = %w(NORTH EAST SOUTH WEST)

  attr_reader :position, :facing, :io

  def initialize(table, io = STDOUT)
    @table = table
    @io = io
  end

  def place(position, facing)
    upcased_facing = facing.upcase
    if FACINGS.include?(upcased_facing)
      @facing = upcased_facing
      move_to(position)
    else
      io.puts "Invalid facing: #{facing}, valid facings: #{FACINGS.join(' ')}"
    end
  end

  def step_forward
    io.puts 'Robot needs to be placed'; return unless placed?
    move_to(@position.send(@facing.downcase))
  end

  def left
    clockwise_turn(TurnCommand::LEFT)
  end

  def right
    clockwise_turn(TurnCommand::RIGHT)
  end

  def location 
    "#{position},#{facing}" if placed?
  end

  def placed?
    !(position.nil?)
  end

  def clockwise_turn(steps)
    index = FACINGS.index(@facing)
    @facing = FACINGS.rotate(steps)[index] if placed?
  end

  private

  def move_to(position) 
    if @table.within_edges?(position)
      @position = position
    else
      io.puts "Can not move or place robot to position: #{position}"
    end
  end
end
