require 'minitest/autorun'
require 'set'

path = File.expand_path('input.txt', __dir__)
input = File.read(path)

places = Set[[0, 0]]

adjacent = ->(h, t) { (h[0] - t[0]).abs <= 1 && (h[1] - t[1]).abs <= 1 }

# p 'Part 1'

# input.each_line do |line|
#   dir, steps = line.split(' ')
#   steps = steps.to_i
#   p "DIRECTIONS: #{dir}, #{steps}"
#   steps.times do
#     p 'BEFORE:'
#     p head, tail
#     # MOVE HEAD
#     case dir
#     when 'U'
#       head = [head[0], head[1] + 1]
#     when 'D'
#       head = [head[0], head[1] - 1]
#     when 'L'
#       head = [head[0] - 1, head[1]]
#     when 'R'
#       head = [head[0] + 1, head[1]]
#     end

#     p 'AFTER:'
#     p head
#     # MOVE TAIL
#     next if adjacent.call(head, tail)

#     case dir
#     when 'U'
#       tail = [tail[0], tail[1] + 1]
#       tail[0] = head[0] if head[0] != tail [0]
#     when 'D'
#       tail = [tail[0], tail[1] - 1]
#       tail[0] = head[0] if head[0] != tail [0]
#     when 'L'
#       tail = [tail[0] - 1, tail[1]]
#       tail[1] = head[1] if head[1] != tail [1]
#     when 'R'
#       tail = [tail[0] + 1, tail[1]]
#       tail[1] = head[1] if head[1] != tail [1]
#     end

#     p tail
#     places.add(tail)
#   end
# end
# p places.size

p 'Part 2'
places = Set[[0, 0]]
head = [0, 0]

rope = Array.new(10) { [0, 0] }

input.each_line do |line|
  dir, steps = line.split(' ')
  steps = steps.to_i
  p "DIRECTIONS: #{dir}, #{steps}"
  steps.times do
    head = rope[0]
    case dir
    when 'U'
      head[1] += 1
    when 'D'
      head[1] -= 1
    when 'L'
      head[0] -= 1
    when 'R'
      head[0] += 1
    end

    rope.each_cons(2) do |head, tail|
      # MOVE current_knot

      next if (head[0] - tail[0]).abs <= 1 && (head[1] - tail[1]).abs <= 1

      # MOVE next_knot
      if head[1] != tail[1]
        tail[1] += (head[1] - tail[1]).positive? ? 1 : -1
      end

      if head[0] != tail[0]
        tail[0] += (head[0] - tail[0]).positive? ? 1 : -1
      end
    end

    p 'AFTER:'
    p head
    p rope

    places.add(rope.last)
  end
end
p rope
p places
p places.size

# Head knot is at index 0
# knots = Array.new(10) { [0, 0] }

# visited = [knots[-1].clone].to_set

# input.each_line do |line|
#   dir, v = line.split
#   v = v.to_i

#   head = knots[0]
#   v.times do
#     case dir
#     when 'R'
#       head[0] += 1
#     when 'L'
#       head[0] -= 1
#     when 'U'
#       head[1] += 1
#     when 'D'
#       head[1] -= 1
#     end

#     knots.each_cons(2) do |head, tail|
#       p head, tail
#       # neighbour check
#       next if (head[0] - tail[0]).abs <= 1 && (head[1] - tail[1]).abs <= 1

#       if head[1] != tail[1]
#         tail[1] += (head[1] - tail[1]).positive? ? 1 : -1
#       end

#       if head[0] != tail[0]
#         tail[0] += (head[0] - tail[0]).positive? ? 1 : -1
#       end
#     end

#     visited << knots[-1].clone
#   end
# end

p knots
puts visited.count

class SolutionTest < Minitest::Test
  def test_adjacent
    adjacent = ->(h, t) { (h[0] - t[0]).abs <= 1 && (h[1] - t[1]).abs <= 1 }

    refute adjacent.call([0, 2], [0, 4])
    refute adjacent.call([2, 2], [0, 2])
    assert adjacent.call([2, 2], [2, 2])
    assert adjacent.call([3, 2], [2, 2])
    assert adjacent.call([2, 3], [2, 2])
  end
end


__END__
R 5
U 8
L 8
D 3
R 17
D 10
L 25
U 20