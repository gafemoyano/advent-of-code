path = File.expand_path("input.txt", __dir__)
input = File.read(path)

puts "#{"-" * 25}PART 1#{"-" * 25}"

priorities = ("a".."z").to_a + ("A".."Z").to_a

result = input
  .each_line
  .map do |line|
  half = line.size / 2
  first = line.slice(0, half).chars
  second = line.slice(half, line.size).chars
  repeated = first.detect { |item| second.count(item) > 0 }
  priorities.index(repeated) + 1
end

p result.sum

puts "#{"-" * 25}PART 2#{"-" * 25}"

priorities = ("a".."z").to_a + ("A".."Z").to_a

result = input
  .each_line
  .each_slice(3)
  .map do |slice|
  first, second, third = slice
  first = first.chars
  second = second.chars
  third.chars

  repeated = first.detect do |item|
    second.count(item) > 0 && third.count(item) > 0
  end

  priorities.index(repeated) + 1
end

p result.sum
