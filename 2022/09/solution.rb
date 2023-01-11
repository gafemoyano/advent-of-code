require 'minitest/autorun'
require 'set'

path = File.expand_path('input.txt', __dir__)
input = File.read(path)

head = [0, 0]
tail = [0, 0]
places = Set[[0, 0]]

adjacent = ->(h, t) { (h[0] - t[0]).abs <= 1 && (h[1] - t[1]).abs <= 1 }

p 'Part 1'

input.each_line do |line|
  dir, steps = line.split(' ')
  steps = steps.to_i
  p "DIRECTIONS: #{dir}, #{steps}"
  steps.times do
    p 'BEFORE:'
    p head, tail
    # MOVE HEAD
    case dir
    when 'U'
      head = [head[0], head[1] + 1]
    when 'D'
      head = [head[0], head[1] - 1]
    when 'L'
      head = [head[0] - 1, head[1]]
    when 'R'
      head = [head[0] + 1, head[1]]
    end

    p 'AFTER:'
    p head
    # MOVE TAIL
    next if adjacent.call(head, tail)

    case dir
    when 'U'
      tail = [tail[0], tail[1] + 1]
      tail[0] = head[0] if head[0] != tail [0]
    when 'D'
      tail = [tail[0], tail[1] - 1]
      tail[0] = head[0] if head[0] != tail [0]
    when 'L'
      tail = [tail[0] - 1, tail[1]]
      tail[1] = head[1] if head[1] != tail [1]
    when 'R'
      tail = [tail[0] + 1, tail[1]]
      tail[1] = head[1] if head[1] != tail [1]
    end

    p tail
    places.add(tail)
  end
end
p places.size

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
R 4
U 4
L 3
D 1
R 4
D 1
L 5
R 2