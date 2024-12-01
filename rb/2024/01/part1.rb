# frozen_string_literal: true

path = File.expand_path("input.txt", __dir__)
input = File.read(path)

# Part 1

left, right = DATA
              .each_line
              .map(&:split)
              .map { |a, b| [a.to_i, b.to_i] }
              .transpose
              .map(&:sort!)

(0..left.size - 1).map do |i|
  (left[i] - right[i]).abs
end
  .sum
  .tap { puts _1 }

__END__
3   4
4   3
2   5
1   3
3   9
3   3
