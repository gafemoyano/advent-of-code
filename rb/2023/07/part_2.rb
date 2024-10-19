require "minitest/autorun"
require "debug"

path = File.expand_path("input.txt", __dir__)
input = File.read(path)

class Hand
  CARDS = %w[A K Q T 9 8 7 6 5 4 3 2 J]

  attr_reader :hand

  def initialize(hand)
    @hand = hand
  end

  def rank
    tally = hand.chars.tally.reject! { _1 == "J" } || {}

    max = tally.values.max
    best = tally.key(max)

    tally = hand
      .gsub("J", best || "J")
      .chars.tally.values.sort

    if tally == [5]
      0
    elsif tally == [1, 4]
      1
    elsif tally == [2, 3]
      2
    elsif tally.include?(3)
      3
    elsif tally.count { _1 == 2 } == 2
      4
    elsif tally.include?(2)
      5
    else
      6
    end
  end

  # Strongest hands first
  def <=>(other)
    result = rank <=> other.rank

    return result unless result.zero?

    hand.chars.zip(other.hand.chars)
      .map { |a, b| CARDS.index(a) <=> CARDS.index(b) }
      .reject(&:zero?)
      .first
  end
end

input.each_line.map do |line|
  hand, bid = line.split
  [Hand.new(hand), bid.to_i]
end.sort_by(&:first)
  .reverse
  .map(&:last)
  .each_with_index
  .sum { |bid, index| (index + 1) * bid }
  .tap { puts _1 }

__END__
Time:        40     81     77     72
Distance:   219   1012   1365   1089
