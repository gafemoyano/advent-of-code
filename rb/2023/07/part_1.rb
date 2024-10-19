require "minitest/autorun"
require "debug"

path = File.expand_path("input.txt", __dir__)
input = File.read(path)

cards = ["A", "K", "Q", "T", "9", "8", "7", "6", "5", "4", "3", "2", "J"].reverse.each_with_index.to_h

def classify(hand, input)
  max = hand.values.max
  best = hand.key(max)

  hand = input.gsub("J", best || "J").chars.tally.values.sort

  case hand[0]
  in [_, 5] then
    7
  in [_, 4] then
    6
  in [_, 3] then
    case hand[1]
    in [_, 2] then
      5
    else
      4
    end
  in [_, 2] then
    case hand[1]
    in [_, 2] then
      3
    else
      2
    end
  else
    1
  end
end

counted_cards = []
types = Hash.new { |hash, key| hash[key] = [] }

input.each_line do |line|
  hand, score = line.split(" ")

  r = hand.each_char.each_with_object(Hash.new(0)) { |char, count|
    count[char] += 1
  }.sort_by { |(card, count)|
        [count, cards[card]]
      }.reverse.to_h.reject! { _1 == "J" } || {}

  type = classify(r, hand)
  types[type] << [hand, score.to_i]
  counted_cards << [r, score.to_i]
end

types = types.sort.to_h

pp types
types.each { |type, hands|
  pp hands
  hands.sort! { |curr, other|
    curr = curr[0]
    other = other[0]
    5.times do |index|
      if curr[index] != other[index]
        break cards[curr[index]] <=> cards[other[index]]
      end
      0
    end
  }
}
pp types

types.flat_map { |key, val| val }.each_with_index.map { |(_hand, score), index|
  score * (index + 1)
}.sum.tap { pp _1 }


__END__
32T3K 765
T55J5 684
KK677 28
KTJJT 220
QQQJA 483
