path = File.expand_path('input.txt', __dir__)
input = File.read(path)

stack_input, move_input = input.split("\n\n")
puts "#{'-' * 25}PART 1#{'-' * 25}"

stacks = stack_input.lines.pop.split(' ').map { [_1, []] }.to_h

stax = stack_input.split("\n")
num_stacks = stax.pop.split.last.to_i

rows = stax.map do |row|
  row.chars.each_slice(4).map { |col| col.join.scan(/\w/).first }
end
puts rows.transpose.map(&:compact)

stack_input.lines.slice(0..-2).reverse.each_with_index do |line, _index|
  stacks['1'].push(line.chars[1]) unless line.chars[1].strip.empty?
  stacks['2'].push(line.chars[5]) unless line.chars[5].strip.empty?
  stacks['3'].push(line.chars[9]) unless line.chars[9].strip.empty?
  stacks['4'].push(line.chars[13]) unless line.chars[13].strip.empty?
  stacks['5'].push(line.chars[17]) unless line.chars[17].strip.empty?
  stacks['6'].push(line.chars[21]) unless line.chars[21].strip.empty?
  stacks['7'].push(line.chars[25]) unless line.chars[25].strip.empty?
  stacks['8'].push(line.chars[29]) unless line.chars[29].strip.empty?
  stacks['9'].push(line.chars[33]) unless line.chars[33].strip.empty?
end

move_input.each_line do |line|
  instructions = line.split(' ')
  qty = instructions[1].to_i
  from = instructions[3]
  to = instructions[5]

  boxes = stacks[from].pop(qty)

  stacks[to].concat(boxes)
end

result = stacks.map do |_key, value|
  value.last
end.join

puts result
