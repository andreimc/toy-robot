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
    unknown_command =  -> { UnknownCommand.new(instruction, io) }
    commands = {
      'PLACE' => -> { params = instruction.split.last; PlaceCommand.new(robot, *params.split(',')) },
      'MOVE' => -> { MoveCommand.new(robot) },
      'LEFT' => -> { TurnCommand.new(robot, TurnCommand::LEFT) },
      'RIGHT' => -> { TurnCommand.new(robot, TurnCommand::RIGHT) },
      'REPORT' => -> { ReportCommand.new(robot, io) },
    }

    begin
      commands.fetch(processed_instruction(instruction), unknown_command).call
    rescue Exception => e
      io.puts "Something went wrong: #{e.message}"
      unknown_command.call
    end
  end

  def processed_instruction(instruction)
    /^PLACE / =~ instruction ? 'PLACE' : instruction
  end
end
