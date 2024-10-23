require "minitest/autorun"
require "debug"

path = File.expand_path("input.txt", __dir__)
input = File.read(path)

TYPES = {
  "|" => {"N" => ["F", "|", "7"], "S" => ["|", "J", "L"]},
  "-" => {"E" => ["-", "7", "J"], "W" => ["-", "L", "F"]},
  "L" => {"N" => ["|", "F", "7"], "E" => ["-", "J", "7"]},
  "J" => {"N" => ["|", "F", "7"], "W" => ["-", "L", "F"]},
  "7" => {"S" => ["|", "J", "L"], "W" => ["-", "L", "F"]},
  "F" => {"S" => ["|", "J", "L"], "E" => ["-", "J", "7"]}
}
DIRS = {"N" => ["F", "|", "7"], "S" => ["|", "J", "L"], "W" => ["-", "L", "F"], "E" => ["-", "J", "7"]}

class Pipe
  attr_accessor :connections, :distance, :type, :from, :to

  def initialize(type)
    @type = type
    @connections = []
    @distance = Float::INFINITY
  end

  def connects?(other, dir)
    return false if other.type == "."
    if type == "S"
      return DIRS[dir].include?(other.type)
    end
    TYPES[type][dir].include?(other.type)
  end
end

map = []
position = []
DATA.each_line.each_with_index do |line, i|
  map << line.strip.each_char.map { Pipe.new(_1) }
  if (j = line.index("S"))
    position = [i, j]
  end
end

start_node = map[position.first][position.last]
start_node.distance = 0

north = map[position[0] - 1][position.last]
south = map[position[0] + 1][position.last]
west = map[position[0]][position.last - 1]
east = map[position.first][position.last + 1]

while start_node.to.nil?
  binding.irb
  if start_node.connects?(north, "N")
    position = [position[0] - 1, position.last]
    start_dir = "N"
    second = map[position.first][position.last]
    start_node.to = second
    next
  end

  if start_node.connects?(south, "S")
    position = [position[0] + 1, position.last]
    start_dir = "S"
    second = map[position.first][position.last]
    start_node.to = second
    next
  end

  if start_node.connects?(west, "W")
    position = [position[0], position.last - 1]
    start_dir = "W"
    second = map[position.first][position.last]
    start_node.to = second
    next
  end
  if start_node.connects?(east, "E")
    position = [position.first, position.last + 1]
    start_dir = "E"
    second = map[position.first][position.last]
    start_node.to = second
    next
  end
end

current_node = start_node.to
current_node.from = start_node

current_node.distance = 1

while start_node.from.nil?
  next_dir = if current_node == start_node.to
    start_dir
  else
    (TYPES[current_node.type].keys - TYPES[current_node.from.type].keys).first
  end

  binding.irb
  case next_dir
  in "N"
    position = [position[0] - 1, position.last]
  in "S"
    position = [position[0] + 1, position.last]
  in "E"
    position = [position[0], position.last - 1]
  in "W"
    position = [position.first, position.last + 1]
  end

  next_node = map[position.first][position.last]
  current_node.to = next_node
  next_node.from = current_node
  next_node.distance = current_node.distance + 1

  current_node = next_node
end
pp position
pp map

__END__
7-F7-
.FJ|7
SJLL7
|F--J
LJ.LJ
