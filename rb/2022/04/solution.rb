path = File.expand_path("input.txt", __dir__)
input = File.read(path)

puts "#{"-" * 25}PART 1#{"-" * 25}"

result = input
  .each_line
  .map { _1.split(",") }
  .map do |couple|
           first, second = couple
           range_1 = first.split("-").map(&:to_i)
           range_2 = second.split("-").map(&:to_i)

           [(range_1[0]..range_1[1]), (range_2[0]..range_2[1])]
         end.filter do |ranges|
  first, second = ranges
  first.cover?(second) || second.cover?(first)
end

p result.size

puts "#{"-" * 25}PART 2#{"-" * 25}"

r2 = input
  .each_line
  .map { _1.split(",") }
  .map do |couple|
       first, second = couple
       range_1 = first.split("-").map(&:to_i)
       range_2 = second.split("-").map(&:to_i)

       [(range_1[0]..range_1[1]), (range_2[0]..range_2[1])]
     end.filter do |ranges|
  r1, r2 = ranges
  r1.cover?(r2.first) || r2.cover?(r1.first)
end

puts r2.size
