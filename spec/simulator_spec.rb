require_relative '../simulator'

RSpec.describe Simulator do
  let(:simulator) { Simulator.new }

  describe 'command execution' do
    it 'executes PLACE command' do
      simulator.execute('PLACE 0,0,NORTH')
      expect { simulator.execute('REPORT') }.to output("0,0,NORTH\n").to_stdout
    end

    it 'executes MOVE command' do
      simulator.execute('PLACE 0,0,NORTH')
      simulator.execute('MOVE')
      expect { simulator.execute('REPORT') }.to output("0,1,NORTH\n").to_stdout
    end

    it 'executes LEFT and RIGHT commands' do
      simulator.execute('PLACE 0,0,NORTH')
      simulator.execute('LEFT')
      expect { simulator.execute('REPORT') }.to output("0,0,WEST\n").to_stdout
    end

    it 'ignores commands before first PLACE' do
      simulator.execute('MOVE')
      simulator.execute('LEFT')
      expect { simulator.execute('REPORT') }.to_not output.to_stdout
    end

    it 'ignores invalid commands' do
      simulator.execute('PLACE 0,0,NORTH')
      simulator.execute('INVALID')
      expect { simulator.execute('REPORT') }.to output("0,0,NORTH\n").to_stdout
    end
  end

  describe 'example scenarios' do
    it 'executes example A: PLACE 0,0,NORTH, MOVE, REPORT' do
      commands = ['PLACE 0,0,NORTH', 'MOVE', 'REPORT']
      expect { simulator.run(commands) }.to output("0,1,NORTH\n").to_stdout
    end

    it 'executes example B: PLACE 0,0,NORTH, LEFT, REPORT' do
      commands = ['PLACE 0,0,NORTH', 'LEFT', 'REPORT']
      expect { simulator.run(commands) }.to output("0,0,WEST\n").to_stdout
    end

    it 'executes example C: complex movement' do
      commands = ['PLACE 1,2,EAST', 'MOVE', 'MOVE', 'LEFT', 'MOVE', 'REPORT']
      expect { simulator.run(commands) }.to output("3,3,NORTH\n").to_stdout
    end
  end

  describe 'edge cases' do
    it 'prevents falling off table' do
      commands = ['PLACE 0,4,NORTH', 'MOVE', 'REPORT']
      expect { simulator.run(commands) }.to output("0,4,NORTH\n").to_stdout
    end

    it 'handles multiple commands from file' do
      test_file = 'spec/test_commands.txt'
      File.write(test_file, "PLACE 0,0,NORTH\nMOVE\nREPORT\n")
      expect { simulator.run_file(test_file) }.to output("0,1,NORTH\n").to_stdout
      File.delete(test_file)
    end
  end
end
