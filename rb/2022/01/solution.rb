path = File.expand_path('input.txt', __dir__)
input = File.read(path)

# Part 1
sorted_calories = input.split("\n\n").map do |elf|
  elf.split("\n").map(&:to_i).sum
end.sort.reverse

puts "#{'-' * 25}PART 1#{'-' * 25}"
p sorted_calories.first

puts "#{'-' * 25}PART 2#{'-' * 25}"
p sorted_calories.first(3).sum
