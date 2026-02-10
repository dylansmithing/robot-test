require_relative 'robot'

class Simulator
  def initialize
    @robot = Robot.new
  end

  def execute(command)
    command = command.strip

    if command.start_with?('PLACE')
      execute_place(command)
    elsif command == 'MOVE'
      @robot.move
    elsif command == 'LEFT'
      @robot.left
    elsif command == 'RIGHT'
      @robot.right
    elsif command == 'REPORT'
      output = @robot.report
      puts output if output
    end
  end

  def run(input)
    commands = input.is_a?(String) ? input.split("\n") : input

    commands.each do |command|
      execute(command)
    end
  end

  def run_file(filename)
    File.readlines(filename).each do |line|
      execute(line)
    end
  end

  private

  def execute_place(command)
    # Parse PLACE X,Y,F
    match = command.match(/PLACE\s+(\d+),(\d+),(NORTH|SOUTH|EAST|WEST)/)

    if match
      x = match[1].to_i
      y = match[2].to_i
      facing = match[3]
      @robot.place(x, y, facing)
    end
  end
end
