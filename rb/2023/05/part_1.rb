
require "minitest/autorun"
require "debug"

path = File.expand_path("input.txt", __dir__)
input = File.read(path)

seeds = []
map = {}

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
    map[name] = {}

    index += 1
    while true
      p "enter"
      next_line = lines[index]
      break unless next_line
      next_line = next_line.strip
      break unless next_line.match?(/(\d+) (\d+) (\d+)/)
      p "after break"

      dest_start, source_start, length = next_line.split.map(&:to_i)

      (source_start...(source_start + length)).each_with_index do |s, i|
        map[name][s] = dest_start + i
      end
      p "after loopy"
      index += 1
    end
  else
    index += 1
  end
end

locations = []

seeds.each do |seed|
  p "seed: #{seed}"
  soil = map["seed-to-soil"][seed] || seed
  fert = map["soil-to-fertilizer"][soil] || soil
  water = map["fertilizer-to-water"][fert] || fert
  light = map["water-to-light"][water] || water
  temperature = map["light-to-temperature"][light] || light
  humidity = map["temperature-to-humidity"][temperature] || temperature
  location = map["humidity-to-location"][humidity] || humidity

  locations << location
end
pp locations.min
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
