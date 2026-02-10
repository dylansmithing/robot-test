#!/usr/bin/env ruby

require_relative 'simulator'

def print_usage
  puts "Toy Robot Simulator"
  puts "==================="
  puts ""
  puts "Usage:"
  puts "  ruby main.rb                  # Interactive mode"
  puts "  ruby main.rb <filename>       # Run commands from file"
  puts ""
  puts "Commands:"
  puts "  PLACE X,Y,F  - Place robot at position (X,Y) facing F (NORTH/SOUTH/EAST/WEST)"
  puts "  MOVE         - Move robot one unit forward"
  puts "  LEFT         - Rotate robot 90 degrees left"
  puts "  RIGHT        - Rotate robot 90 degrees right"
  puts "  REPORT       - Display current position and facing direction"
  puts "  EXIT         - Exit interactive mode"
  puts ""
end

if ARGV.length == 0
  # Interactive mode
  print_usage

  simulator = Simulator.new

  puts "Enter commands (type EXIT to quit):"
  loop do
    print "> "
    input = gets
    break if input.nil?

    command = input.strip
    break if command.upcase == 'EXIT'

    simulator.execute(command)
  end
elsif ARGV.length == 1
  # File mode
  filename = ARGV[0]

  if File.exist?(filename)
    simulator = Simulator.new
    simulator.run_file(filename)
  else
    puts "Error: File '#{filename}' not found"
    exit 1
  end
else
  print_usage
  exit 1
end
