path = File.expand_path('input.txt', __dir__)
input = File.read(path)

# Part 1
RED = 12
GREEN = 13
BLUE = 14

input
  .each_line
  .sum do |line|
    blue  = line.scan(/(\d+) blue/).flatten.map(&:to_i).max
    red   = line.scan(/(\d+) red/).flatten.map(&:to_i).max
    green = line.scan(/(\d+) green/).flatten.map(&:to_i).max

    if blue > BLUE || red > RED || green > GREEN
      0
    else
      line.scan(/Game (\d*)/).flatten.first.to_i
    end
  end
  .tap { puts _1 }

# Part 2

input
  .each_line
  .sum {
    blue  = _1.scan(/(\d+) b/).flatten.map(&:to_i).max
    red   = _1.scan(/(\d+) r/).flatten.map(&:to_i).max
    green = _1.scan(/(\d+) g/).flatten.map(&:to_i).max

    blue * red * green
  }
  .tap { puts _1 }
