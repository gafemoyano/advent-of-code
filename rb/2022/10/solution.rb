# require 'minitest/autorun'
require "debug"

path = File.expand_path("input.txt", __dir__)
input = File.read(path)

p "Part 1"

sum = 0
checkpoints = [20, 60, 100, 140, 180, 220]
x = 1
queue = {}
cycle = 0
crt = Array.new(6) { Array.new(40) }

coords = [0, 0]

move_cursor = lambda { |cycle|
  # binding.break
  if cycle % 40 == 0
    coords[0] = 0
    if coords[1] >= 5
      coords[1] = 0
    else
      coords[1] += 1
    end
  else
    coords[0] += 1
  end
}

draw = lambda do |_cycle|
  current = coords[0]
  # binding.break
  crt[coords[1]][coords[0]] = if [x - 1, x, x + 1].include?(current)
    "#"
  else
    "."
  end
end

run_cycle = lambda do |cycle|
  if checkpoints.include?(cycle)
    puts "#{x} times #{cycle}"
    sum += (x * cycle)
  end
  draw.call(cycle)
  x += queue[cycle] if queue[cycle]
  move_cursor.call(cycle)
end

input.each_line.map(&:chomp).each do |line|
  case line.split
  in [/^noop$/]
    cycle += 1
    queue[cycle] = nil
    run_cycle.call(cycle)

  in ["addx", /\d+/ => value]
    queue[cycle + 1] = nil
    queue[cycle + 2] = value.to_i
    cycle += 1
    run_cycle.call(cycle)

    cycle += 1
    run_cycle.call(cycle)

  end
end

crt.each do |line|
  puts line.join("")
end

p sum

__END__
addx 15
addx -11
addx 6
addx -3
addx 5
addx -1
addx -8
addx 13
addx 4
noop
addx -1
addx 5
addx -1
addx 5
addx -1
addx 5
addx -1
addx 5
addx -1
addx -35
addx 1
addx 24
addx -19
addx 1
addx 16
addx -11
noop
noop
addx 21
addx -15
noop
noop
addx -3
addx 9
addx 1
addx -3
addx 8
addx 1
addx 5
noop
noop
noop
noop
noop
addx -36
noop
addx 1
addx 7
noop
noop
noop
addx 2
addx 6
noop
noop
noop
noop
noop
addx 1
noop
noop
addx 7
addx 1
noop
addx -13
addx 13
addx 7
noop
addx 1
addx -33
noop
noop
noop
addx 2
noop
noop
noop
addx 8
noop
addx -1
addx 2
addx 1
noop
addx 17
addx -9
addx 1
addx 1
addx -3
addx 11
noop
noop
addx 1
noop
addx 1
noop
noop
addx -13
addx -19
addx 1
addx 3
addx 26
addx -30
addx 12
addx -1
addx 3
addx 1
noop
noop
noop
addx -9
addx 18
addx 1
addx 2
noop
noop
addx 9
noop
noop
noop
addx -1
addx 2
addx -37
addx 1
addx 3
noop
addx 15
addx -21
addx 22
addx -6
addx 1
noop
addx 2
addx 1
noop
addx -10
noop
noop
addx 20
addx 1
addx 2
addx 2
addx -6
addx -11
noop
noop
noop