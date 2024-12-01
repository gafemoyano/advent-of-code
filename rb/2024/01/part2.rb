# frozen_string_literal: true
#
path = File.expand_path('input.txt', __dir__)
input = File.read(path)

# Part 1
left = []
right = []

input.each_line.map(&:split).each do |(a, b)|
  left << a.to_i
  right << b.to_i
end

left.map do |i|
  right.count(i) * i
end.sum.tap { pp _1 }

__END__
3   4
4   3
2   5
1   3
3   9
3   3
