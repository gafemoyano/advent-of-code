path = File.expand_path('input.txt', __dir__)
input = File.read(path)

puts "#{'-' * 25}PART 1#{'-' * 25}"

result = input
         .lines
         .map { _1.split(' ') }
         .map do |match|
  case match
  # VS ROCK
  in ['A', 'X']
    1 + 3
  in ['A', 'Y']
    2 + 6
  in ['A', 'Z']
    3 + 0
  # VS PAPER
  in ['B', 'X']
    1
  in ['B', 'Y']
    2 + 3
  in ['B', 'Z']
    3 + 6
  # VS SCISSORS
  in ['C', 'X']
    1 + 6
  in ['C', 'Y']
    2 + 0
  in ['C', 'Z']
    3 + 3
  else
    raise StandardError('unrecognized pattern')
           end
end.sum

p result

puts "#{'-' * 25}PART 2#{'-' * 25}"
part2 = input
        .lines
        .map { _1.split(' ') }
        .map do |match|
  case match
  # VS ROCK
  in ['A', 'X']
    3 + 0
  in ['A', 'Y']
    1 + 3
  in ['A', 'Z']
    2 + 6
  # VS PAPER
  in ['B', 'X']
    1 + 0
  in ['B', 'Y']
    2 + 3
  in ['B', 'Z']
    3 + 6
  # VS SCISSORS
  in ['C', 'X']
    2 + 0
  in ['C', 'Y']
    3 + 3
  in ['C', 'Z']
    1 + 6
  else
    raise StandardError('unrecognized pattern')
           end
end.sum

p part2
