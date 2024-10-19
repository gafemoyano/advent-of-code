require "minitest/autorun"
require "debug"

path = File.expand_path("input.txt", __dir__)
input = File.read(path)

seeds = []
mapping = {}

lines = input.each_line.to_a
index = 0

while index < lines.size
  p "enter outer"
  print index
  line = lines[index].strip

  case line
  in /seeds:/
    seeds = line.split(":")[1].strip.split(" ").map(&:to_i)
    index += 1
  in /(\w+-to-\w+) map:/
    name = $1
    mapping[name] = {}

    index += 1
    while true
      next_line = lines[index]
      break unless next_line
      next_line = next_line.strip
      break unless next_line.match?(/(\d+) (\d+) (\d+)/)

      dest_start, source_start, length = next_line.split.map(&:to_i)
      stop = (source_start + length)
      mapping[name][(source_start...stop)] = dest_start - source_start

      index += 1
    end
  else
    index += 1
  end
end

pp mapping
locations = []

seeds.each do |seed|
  location = mapping.values.reduce(seed) do |start, mapping|
    res = start
    mapping.each do |(range, offset)|
      if range.include?(res)
        res = res + offset
        break
      end
    end
    res
  end

  # soil = map["seed-to-soil"].reduce(seed) do |dest, (source, offset)|
  #   if source.include?(dest)
  #     dest + offset
  #   else
  #     dest
  #   end
  # end
  locations << location
end
pp locations.min
# pp locations.min
# Seed 79, soil 81, fertilizer 81, water 81, light 74, temperature 78, humidity 78, location 82.

class SolutionTest < Minitest::Test
  def test_score
  end
end

__END__
seeds: 79 14 55 13

seed-to-soil map:
50 98 2
52 50 48

soil-to-fertilizer map:
0 15 37
37 52 2
39 0 15

fertilizer-to-water map:
49 53 8
0 11 42
42 0 7
57 7 4

water-to-light map:
88 18 7
18 25 70

light-to-temperature map:
45 77 23
81 45 19
68 64 13

temperature-to-humidity map:
0 69 1
1 0 69

humidity-to-location map:
60 56 37
56 93 4
