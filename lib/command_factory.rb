require_relative 'commands/place_command'
require_relative 'commands/move_command'
require_relative 'commands/turn_command'
require_relative 'commands/report_command'
require_relative 'commands/unknown_command'

class CommandFactory

  attr_reader :robot, :io

  def initialize(robot, io = STDOUT)
    @robot = robot
    @io = io
  end

  def create(instruction)
    command_for(instruction)
  end

  private

  def command_for(instruction)
    commands = {
        'PLACE' => -> { params = instruction.split.last; PlaceCommand.new(robot, *params.split(',')) },
        'MOVE' => -> { MoveCommand.new(robot) },
        'LEFT' => -> { TurnCommand.new(robot, TurnCommand::LEFT) },
        'RIGHT' => -> { TurnCommand.new(robot, TurnCommand::RIGHT) },
        'REPORT' => -> { ReportCommand.new(robot, io) },
    }

    commands.fetch(processed_instruction(instruction), -> { UnknownCommand.new(instruction, io) }).call
  end

  def processed_instruction(instruction)
    /^PLACE / =~ instruction ? 'PLACE' : instruction
  end
end
