# require 'minitest/autorun'
require "debug"

path = File.expand_path("input.txt", __dir__)
File.read(path)

p "Part 1"

items = [
  [72, 97],
  [55, 70, 90, 74, 95],
  [74, 97, 66, 57],
  [86, 54, 53],
  [50, 65, 78, 50, 62, 99],
  [90],
  [88, 92, 63, 94, 96, 82, 53, 53],
  [70, 60, 71, 69, 77, 70, 98]
]
inspections = Array.new(items.size) { |_index| 0 }

divisor = [19, 7, 17, 13, 11, 2, 5, 3].reduce(&:*)

# So this is the way to find the least common multiple, but since they are
# all primes it means it' s just their multiplication
# divisor = [19, 8, 17, 13, 11, 2, 5, 3].reduce(1, :lcm)

test = lambda { |worry, denominator, success, failure|
  chill = worry % divisor

  p "worry: #{worry}"
  p "chill: #{chill}"

  if (chill % denominator).zero?
    items[success].push(chill)
  else
    items[failure].push(chill)
  end
}

10_0.times do |i|
  p i
  # monkey 0
  bag = items[0]
  while bag.any?
    inspections[0] = inspections[0] += 1
    item = bag.shift
    worry = item * 13
    test.call(worry, 19, 5, 6)
  end

  # Monkey 1
  bag = items[1]
  while bag.any?
    inspections[1] = inspections[1] += 1
    item = bag.shift
    worry = item * item
    test.call(worry, 7, 5, 0)
  end

  # Monkey 2
  bag = items[2]
  while bag.any?
    inspections[2] = inspections[2] += 1
    item = bag.shift
    worry = item + 6
    test.call(worry, 17, 1, 0)
  end

  # Monkey 3
  bag = items[3]
  while bag.any?
    inspections[3] = inspections[3] += 1
    item = bag.shift
    worry = item + 2
    test.call(worry, 13, 1, 2)
  end

  # Monkey 4
  bag = items[4]
  while bag.any?
    inspections[4] = inspections[4] += 1
    item = bag.shift
    worry = item + 3
    test.call(worry, 11, 3, 7)
  end

  # Monkey 5
  bag = items[5]
  while bag.any?
    inspections[5] = inspections[5] += 1
    item = bag.shift
    worry = item + 4
    test.call(worry, 2, 4, 6)
  end

  # Monkey 6
  bag = items[6]
  while bag.any?
    inspections[6] = inspections[6] += 1
    item = bag.shift
    worry = item + 8
    test.call(worry, 5, 4, 7)
  end

  # Monkey 7
  bag = items[7]
  while bag.any?
    inspections[7] = inspections[7] += 1
    item = bag.shift
    worry = item * 7
    test.call(worry, 3, 2, 3)
  end

  p items
  p inspections
end

p "----------INSPECTIONS--------------"
p inspections.sort!.reverse!
p "MONKEY BUSINESS"
p inspections[0] * inspections[1]


__END__

Monkey 0:
  Starting items: 79, 98
  Operation: new = old * 19
  Test: divisible by 23
    If true: throw to monkey 2
    If false: throw to monkey 3

Monkey 1:
  Starting items: 54, 65, 75, 74
  Operation: new = old + 6
  Test: divisible by 19
    If true: throw to monkey 2
    If false: throw to monkey 0

Monkey 2:
  Starting items: 79, 60, 97
  Operation: new = old * old
  Test: divisible by 13
    If true: throw to monkey 1
    If false: throw to monkey 3

Monkey 3:
  Starting items: 74
  Operation: new = old + 3
  Test: divisible by 17
    If true: throw to monkey 0
    If false: throw to monkey 1
