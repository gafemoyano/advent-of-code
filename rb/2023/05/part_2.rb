require "minitest/autorun"
require "debug"

path = File.expand_path("input.txt", __dir__)
input = File.read(path)

seeds = []
maps = {}

lines = input.each_line.to_a
index = 0

while index < lines.size
  print index
  line = lines[index].strip

  case line
  in /seeds:/
    seeds = line.split(":")[1].strip.split(" ").map(&:to_i)
    index += 1
  in /(\w+-to-\w+) map:/
    name = $1
    maps[name] = {}

    index += 1
    while true
      next_line = lines[index]
      break unless next_line
      next_line = next_line.strip
      break unless next_line.match?(/(\d+) (\d+) (\d+)/)

      dest_start, source_start, length = next_line.split.map(&:to_i)
      stop = (source_start + length)
      maps[name][(source_start...stop)] = dest_start - source_start

      index += 1
    end
  else
    index += 1
  end
end

seed_ranges = seeds.each_slice(2).map { |position, range| (position...(position + range)) }

def overlapping_range(a, b)
  if b.begin <= a.end && a.begin <= b.end
    [a.begin, b.begin].max..[a.end, b.end].min
  end
end
pp maps
soils = maps.values.reduce(seed_ranges) do |sources, mapping|
  pp sources
  sources.flat_map do |seed_range|
    destinations = []

    current_seed = seed_range.begin

    mapping.sort_by { |range, _offset| range.begin }.each { |range, offset|
      matching_range = overlapping_range(range, seed_range)

      if matching_range

        destinations << ((matching_range.begin + offset)..(matching_range.end + offset))
        current_seed = matching_range.end + 1
      end
    }

    if current_seed < seed_range.end
      destinations << (current_seed..seed_range.end)
    end

    destinations

    # location = mapping.sort_by { |range, offset| range.begin }.values.reduce(seed) do |start, mapping|
    #   res = start

    #   mapping.each do |(range, offset)|
    #     if range.include?(res)
    #       res += offset
    #       break
    #     end
    #   end
    #   res
    # end
    # range_locations << location
  end
end

pp soils.map { _1.begin }.min
# pp locations.min
# Seed 79, soil 81, fertilizer 81, water 81, light 74, temperature 78, humidity 78, location 82.

maps
  .values
  .reduce(seed_ranges) { |sources, maps|
    sources.flat_map { |source_range|
      destinations = []

      curr = source_range.begin

      maps
        .sort_by { |range, offset| range.begin }
        .each { |range, offset|
          matching_range = overlapping_range(range, source_range)

          if matching_range
            # if matching_range.begin != curr
            #   # This doesn't seem to be required for my given input
            #   # but I _think_ this is required for sources where there
            #   # is no mapping
            #   destinations << (curr..(matching_range.begin - 1))
            # end

            destinations << (
              (matching_range.begin + offset)..(matching_range.end + offset)
            )
            curr = matching_range.end + 1
          end
        }

      if curr < source_range.end
        destinations << (curr..source_range.end)
      end

      destinations
    }
  }
  .min_by(&:begin)
  .begin
  .tap { puts _1 }
class SolutionTest < Minitest::Test
  def test_score
  end
end

__END__
seeds: 79 14 55

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
