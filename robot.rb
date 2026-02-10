class Robot
  DIRECTIONS = [:north, :east, :south, :west]
  TABLE_WIDTH = 5
  TABLE_LENGTH = 5

  attr_reader :x, :y, :facing

  def initialize
    @x = nil
    @y = nil
    @facing = nil
    @placed = false
  end

  def place(x, y, facing)
    facing_sym = facing.downcase.to_sym

    return unless valid_position?(x, y) && DIRECTIONS.include?(facing_sym)

    @x = x
    @y = y
    @facing = facing_sym
    @placed = true
  end

  def move
    return unless @placed

    new_x, new_y = next_position

    if valid_position?(new_x, new_y)
      @x = new_x
      @y = new_y
    end
  end

  def left
    return unless @placed

    current_index = DIRECTIONS.index(@facing)
    @facing = DIRECTIONS[(current_index - 1) % 4]
  end

  def right
    return unless @placed

    current_index = DIRECTIONS.index(@facing)
    @facing = DIRECTIONS[(current_index + 1) % 4]
  end

  def report
    return unless @placed

    "#{@x},#{@y},#{@facing.to_s.upcase}"
  end

  private

  def valid_position?(x, y)
    x >= 0 && x < TABLE_WIDTH && y >= 0 && y < TABLE_LENGTH
  end

  def next_position
    case @facing
    when :north
      [@x, @y + 1]
    when :east
      [@x + 1, @y]
    when :south
      [@x, @y - 1]
    when :west
      [@x - 1, @y]
    end
  end
end
