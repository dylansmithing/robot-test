require_relative '../robot'

RSpec.describe Robot do
  let(:robot) { Robot.new }

  describe '#place' do
    it 'places robot at valid position' do
      robot.place(0, 0, 'NORTH')
      expect(robot.x).to eq(0)
      expect(robot.y).to eq(0)
      expect(robot.facing).to eq(:north)
    end

    it 'ignores invalid positions' do
      robot.place(-1, 0, 'NORTH')
      expect(robot.x).to be_nil

      robot.place(5, 5, 'NORTH')
      expect(robot.x).to be_nil
    end

    it 'allows replacing position' do
      robot.place(0, 0, 'NORTH')
      robot.place(3, 3, 'SOUTH')
      expect(robot.report).to eq('3,3,SOUTH')
    end
  end

  describe '#move' do
    it 'moves robot forward in facing direction' do
      robot.place(2, 2, 'NORTH')
      robot.move
      expect(robot.report).to eq('2,3,NORTH')
    end

    it 'prevents falling off table edges' do
      robot.place(0, 4, 'NORTH')
      robot.move
      expect(robot.report).to eq('0,4,NORTH')

      robot.place(4, 0, 'EAST')
      robot.move
      expect(robot.report).to eq('4,0,EAST')
    end

    it 'ignores move before placement' do
      robot.move
      expect(robot.x).to be_nil
    end
  end

  describe '#left and #right' do
    it 'rotates left correctly' do
      robot.place(0, 0, 'NORTH')
      robot.left
      expect(robot.facing).to eq(:west)
    end

    it 'rotates right correctly' do
      robot.place(0, 0, 'NORTH')
      robot.right
      expect(robot.facing).to eq(:east)
    end

    it 'does not change position when rotating' do
      robot.place(2, 3, 'NORTH')
      robot.left
      expect(robot.report).to eq('2,3,WEST')
    end
  end

  describe '#report' do
    it 'returns formatted position string' do
      robot.place(3, 4, 'EAST')
      expect(robot.report).to eq('3,4,EAST')
    end

    it 'returns nil when not placed' do
      expect(robot.report).to be_nil
    end
  end

  describe 'example scenarios' do
    it 'completes example A: PLACE 0,0,NORTH then MOVE' do
      robot.place(0, 0, 'NORTH')
      robot.move
      expect(robot.report).to eq('0,1,NORTH')
    end

    it 'completes example B: PLACE 0,0,NORTH then LEFT' do
      robot.place(0, 0, 'NORTH')
      robot.left
      expect(robot.report).to eq('0,0,WEST')
    end

    it 'completes example C: complex movement sequence' do
      robot.place(1, 2, 'EAST')
      robot.move
      robot.move
      robot.left
      robot.move
      expect(robot.report).to eq('3,3,NORTH')
    end
  end
end
