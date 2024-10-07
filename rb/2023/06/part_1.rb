require "minitest/autorun"
require "debug"

path = File.expand_path("input.txt", __dir__)
input = File.read(path)

times = DATA.readline.scan(/\d+/).map(&:to_i)
distances = DATA.readline.scan(/\d+/).map(&:to_i)

times.zip(distances).map { |time, record|
  time.times.count do |hold|
    hold * (time - hold) > record
  end
}
  .reduce(:*)
  .tap { puts _1 }

# pp locations.min
# Seed 79, soil 81, fertilizer 81, water 81, light 74, temperature 78, humidity 78, location 82.

class SolutionTest < Minitest::Test
  def test_score
  end
end

__END__
Time:        40     81     77     72
Distance:   219   1012   1365   1089
