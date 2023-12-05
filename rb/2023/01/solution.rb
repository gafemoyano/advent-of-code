path = File.expand_path('input.txt', __dir__)
input = File.read(path)

# Part 1
input
  .each_line
  .sum { |line| line.scan(/\d/).values_at(0, 1).join.to_i }
  .tap { puts _1 }

# Part 2
DIGITS = { 'one' => 1, 'two' => 2, 'three' => 3, 'four' => 4, 'five' => 5, 'six' => 6, 'seven' => 7, 'eight' => 8,
           'nine' => 9 }

input
  .each_line
  .sum do
  _1.scan(/(?=(#{DIGITS.keys.join("|")}|\d))/)
    .flatten
    .values_at(0, -1)
    .map { |match| DIGITS[match] || match }
    .join
    .to_i
end.tap { puts _1 }
