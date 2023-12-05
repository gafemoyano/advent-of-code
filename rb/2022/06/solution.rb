require 'minitest/autorun'

def read_input
  path = File.expand_path('input.txt', __dir__)
  File.read(path)
end

def part_one
  input = read_input.chomp

  (0..(input.length - 4)).each do |index|
    current = input[index, 4]

    next unless all_different(current)

    return [current, index, index + 4]
  end
end

def part_two
  input = read_input.chomp

  (0..(input.length - 14)).each do |index|
    current = input[index, 14]

    next unless all_different(current)

    return [current, index, index + 14]
  end
end

def all_different(str)
  str.chars.uniq.length == str.length
end

puts "#{'-' * 25}PART 1#{'-' * 25}"
part_one

puts "#{'-' * 25}PART 2#{'-' * 25}"
p part_two

class SolutionTest < Minitest::Test
  def test_file_input
    input = read_input
    assert !input.nil?
  end

  def test_all_different
    assert all_different('hola')
    assert !all_different('aaaa')
  end

  def test_part_one
    assert_equal part_one, ['jqvg', 1790, 1794]
  end

  def test_part_two
    result = part_two

    assert result[0].is_a? String
    assert all_different(result[0])
  end
end
