require "minitest/autorun"
require "debug"

path = File.expand_path("input.txt", __dir__)
input = File.read(path)

time = DATA.readline.scan(/\d+/).join.to_i
rec = DATA.readline.scan(/\d+/).join.to_i

time.times.count { |hold|
  hold * (time - hold) > rec
}.tap { puts _1 }

class SolutionTest < Minitest::Test
  def test_score
  end
end

__END__
Time:        40     81     77     72
Distance:   219   1012   1365   1089
