# require 'minitest/autorun'
require 'debug'

path = File.expand_path('input.txt', __dir__)
input = File.read(path)

p 'Part 1'

letters = ('a'..'z').to_a
map = []

grid = input.split("\n").map(&:chars)

p grid

heights = Array.new(grid.size) { Array.new(grid[0].size) }
distances = {}
neighbors = []
e = nil

grid.each_with_index do |row, x|
  row.each_with_index do |cell, y|
    case cell
    when 'a'
      heights[x][y] = 1
      distances[[x, y]] = 0
      neighbors << [x, y]
    when 'E'
      heights[x][y] = 26
      e = [x, y]
    else
      heights[x][y] = cell.ord - 'a'.ord + 1
    end
  end
end

until neighbors.empty?
  x, y = neighbors.shift
  distance = distances[[x, y]]

  [[0, 1], [0, -1], [1, 0], [-1, 0]].each do |dx, dy|
    nx = x + dx
    ny = y + dy

    if nx.between?(0, grid.size - 1) && ny.between?(0, grid.first.size - 1) && heights[nx][ny] <= heights[x][y] + 1
      if distances[[nx, ny]].nil? || distances[[nx, ny]] > distance + 1
        neighbors << [nx, ny]
        distances[[nx, ny]] = distance + 1
      end
    end
  end
end

p distances
p distances[e]

# class Vertex
#   attr_accessor :position, :letter

#   def initialize(position, letter)
#     self.position = position
#     self.letter = case letter
#                   when 'S'
#                     'a'
#                   when 'E'
#                     'z'
#                   else
#                     letter
#                   end
#   end

#   def altitude
#     ('a'..'z').to_a.find_index(letter)
#   end

#   def distance(other)
#     other.altitude - altitude
#   end

#   def ==(other)
#     self.class == other.class &&
#       @position == other.position
#   end
# end

# Edge = Struct.new(:source, :destination, :len)

# class Terrain
#   attr_accessor :position, :target, :vertices, :edges

#   def initialize
#     @vertices = []
#     @edges = []
#   end

#   def add_vertex(vertex)
#     return vertex if find_vertex(vertex.position[0], vertex.position[1])

#     @vertices.append(vertex)
#   end

#   def connect(src, dest, len = 1)
#     return if dest.altitude - src.altitude > 1

#     @edges.append(Edge.new(src, dest, len))

#     # @edges.append(Edge.new(dest, src, len))
#   end

#   def find_vertex(row, col)
#     @vertices.find { _1.position == [row, col] }
#   end

#   def neighbors(vertex)
#     @edges.map do |edge|
#       edge.destination if edge.source.position == vertex.position
#     end.uniq.compact
#   end

#   def length_between(source, destination)
#     @edges.each do |edge|
#       return edge.length if edge.source == source && edge.destination == destination
#     end
#     nil
#   end

#   def traverse
#     distances = {}
#     previouses = {}

#     vertices.each do |v|
#       distances[v] = Float::INFINITY
#       previouses[v] = nil
#     end

#     distances[position] = 0
#     rest = vertices.clone

#     until rest.empty?
#       nearest = nil

#       rest.each do |min|
#         nearest = min if !nearest || (distances[min] && distances[min] < distances[nearest])
#       end

#       break unless distances[nearest] == Float::INFINITY # Infinity

#       return distances[find_vertex(target[0], target[1])] if nearest.position == target

#       neighbors(nearest).each do |vertex|
#         alt = distances[nearest] + length_between(nearest, vertex)

#         if distances[vertex].nil? || alt < distances[vertex]
#           distances[vertex] = alt
#           previouses[vertex] = nearest
#         end
#       end

#       rest.delete(nearest)
#     end
#     distances
#   end
# end

# graph = Terrain.new

# map = DATA.each_line.map { _1.strip.split('') }

# pp map
# # Initialize vertices here
# map.each_with_index do |line, index|
#   line.each_with_index do |letter, col_index|
#     case letter
#     when 'S'
#       graph.position = [index, col_index]
#     when 'E'
#       graph.target = [index, col_index]
#     end

#     graph.add_vertex(Vertex.new([index, col_index], letter))
#   end
# end

# graph.vertices.each do |vertex|
#   row, col = vertex.position
#   # north
#   if col - 1 >= 0
#     nn = graph.find_vertex(row, col - 1)
#     graph.connect(vertex, nn) if nn
#   end
#   # east
#   en = graph.find_vertex(row + 1, col)
#   graph.connect(vertex, en) if en

#   # south
#   sn = graph.find_vertex(row, col + 1)
#   graph.connect(vertex, sn) if sn

#   # west
#   if row - 1 >= 0
#     wn = graph.find_vertex(row - 1, col)
#     graph.connect(vertex, wn) if wn
#   end
# end

# pp graph.traverse


__END__
Sabqponm
abcryxxl
accszExk
acctuvwj
abdefghi