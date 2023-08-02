# require 'minitest/autorun'
require 'debug'

path = File.expand_path('input.txt', __dir__)
input = File.read(path)

p 'Part 1'

letters = ('a'..'z').to_a
map = []

class Vertex
  attr_accessor :position, :letter

  def initialize(position, letter)
    self.position = position
    self.letter = case letter
                  when 'S'
                    'a'
                  when 'E'
                    'z'
                  else
                    letter
                  end
  end

  def altitude
    ('a'..'z').to_a.find_index(letter)
  end

  def distance(other)
    other.altitude - altitude
  end
end

Edge = Struct.new(:source, :destination, :len)

class Terrain
  attr_accessor :position, :target, :vertices, :edges

  def initialize
    @vertices = []
    @edges = []
  end

  def add_vertex(vertex)
    return vertex if find_vertex(vertex.position[0], vertex.position[1])

    @vertices.append(vertex)
  end

  def connect(src, dest, len = 1)
    return if dest.altitude - src.altitude > 1

    @edges.append(Edge.new(src, dest, len))

    # @edges.append(Edge.new(dest, src, len))
  end

  def find_vertex(row, col)
    @vertices.find { _1.position == [row, col] }
  end

  def traverse
    distances = {}
    previouses = {}

    vertices.each do |v|
      distances[v] = Float::INFINITY
      previouses[v] = nil
    end
    distances[position] = 0
    rest = vertices.clone

    until rest.empty?
      nearest = rest.reduce do |a, b|
        next a unless distances[a]
        next b unless distances[b]
        next a if distances[a] < distances[b]

        b
      end
      break unless distances[nearest] == Float::INFINITY # Infinity

      return distances[find_vertex(target)] if target && nearest.position == target

    end
  end
end

graph = Terrain.new

position = []
target = []
map = DATA.each_line.map { _1.strip.split('') }

pp map
# Initialize vertices here
map.each_with_index do |line, index|
  line.each_with_index do |letter, col_index|
    case letter
    when 'S'
      graph.position = [index, col_index]
    when 'E'
      graph.target = [index, col_index]
    end

    graph.add_vertex(Vertex.new([index, col_index], letter))
  end
end

graph.vertices.each do |vertex|
  row, col = vertex.position
  # north
  if col - 1 >= 0
    nn = graph.find_vertex(row, col - 1)
    graph.connect(vertex, nn) if nn
  end
  # east
  en = graph.find_vertex(row + 1, col)
  graph.connect(vertex, en) if en

  # south
  sn = graph.find_vertex(row, col + 1)
  graph.connect(vertex, sn) if sn

  # west
  if row - 1 >= 0
    wn = graph.find_vertex(row - 1, col)
    graph.connect(vertex, wn) if wn
  end
end

# # neighbors
# map.each_with_index do |line, _index|
#   line.each_with_index do |letter, col_index|
#     # north
#     if col_index - 1 >= 0 && map.at(index)&.at(col_index - 1)
#       neighbor = graph.add_vertex(Vertex.new([index, col_index - 1], letter))
#       graph.connect(vertex, neighbor)
#     end
#     # east
#     if map.at(index + 1)&.at(col_index)
#       neighbor = graph.add_vertex(Vertex.new([index + 1, col_index], letter))
#       graph.connect(vertex, neighbor)
#     end
#     # south
#     if map.at(index)&.at(col_index + 1)
#       neighbor = graph.add_vertex(Vertex.new([index, col_index + 1], letter))
#       graph.connect(vertex, neighbor)
#     end
#     # west
#     if index - 1 >= 0 && map.at(index - 1)&.at(col_index)
#       neighbor = graph.add_vertex(Vertex.new([index - 1, col_index], letter))
#       graph.connect(vertex, neighbor)
#     end
#   end
# end

pp graph.vertices.map { [_1.letter, _1.altitude] }
pp graph.edges
p position
p target

pp map

__END__
Sabqponm
abcryxxl
accszExk
acctuvwj
abdefghi