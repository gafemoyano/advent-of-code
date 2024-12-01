require "minitest/autorun"
require "debug"

path = File.expand_path("input.txt", __dir__)
input = File.read(path)

points = 0
# lines = DATA
# lines = input.each_line
# input.each_line do |line|
#   numbers = line
#     .split(":")[1]
#     .split("|")
#     .map(&:strip)
#     .map { _1.split(" ").map(&:to_i) }

#   mine, winning = numbers
#   count = winning.intersection(mine).size
#   score = if count < 2
#     count
#   else
#     2**(count - 1)
#   end

#   points += score

#   p "score #{score}"
# end
p "========POINTS========="
p points

p "========PART 2========="

scratch = {
  1 => 1
}

input.each_line do |line|
  card_number = line.match(/Card\s+(\d+):/)[1].to_i
  scratch[card_number] ||= 1
  numbers = line
    .split(":")[1]
    .split("|")
    .map(&:strip)
    .map { _1.split(" ").map(&:to_i) }

  mine, winning = numbers
  count = winning.intersection(mine).size

  scratch[card_number].times do
    (1..count).each do |i|
      scratch[card_number + i] ||= 1
      scratch[card_number + i] += 1
    end
  end
end
p "========POINTS========="
p scratch.values.sum

class SolutionTest < Minitest::Test
  def test_score
  end
end

__END__
Card 1: 41 48 83 86 17 | 83 86  6 31 17  9 48 53
Card 2: 13 32 20 16 61 | 61 30 68 82 17 32 24 19
Card 3:  1 21 53 59 44 | 69 82 63 72 16 21 14  1
Card 4: 41 92 73 84 69 | 59 84 76 51 58  5 54 83
Card 5: 87 83 26 28 32 | 88 30 70 12 93 22 82 36
Card 6: 31 18 13 56 72 | 74 77 10 23 35 67 36 11
