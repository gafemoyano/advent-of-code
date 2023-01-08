path = File.expand_path('input.txt', __dir__)
input = File.read(path)

grid = input.each_line.map { _1.chomp.chars.map(&:to_i) }
tgrid = grid.transpose

visibility = Array.new(grid.size) { Array.new(grid.first.size) { 1 } }

(1..(grid.length - 2)).step(1) do |row|
  (1..(grid.length - 2)).step(1) do |column|
    current_tree = grid[row][column]
    east = grid[row].slice(column + 1, grid.length).any? { _1 >= current_tree }
    west = grid[row].slice(0, column).any? { _1 >= current_tree }
    south = tgrid[column].slice(row + 1, grid.length).any? { _1 >= current_tree }
    north = tgrid[column].slice(0, row).any? { _1 >= current_tree }

    visibility[row][column] = 0 if east && west && south && north
  end
end
p 'part 1'
p visibility.flatten.filter { _1 == 1 }.count

p 'part 2'
scores = Array.new(grid.size) { Array.new(grid.first.size) { 0 } }

(1..(grid.length - 2)).step(1) do |row|
  (1..(grid.length - 2)).step(1) do |column|
    current_tree = grid[row][column]

    east = grid[row].slice(column + 1, grid.length).each_with_object([]) do |tree, ary|
      ary << tree
      break ary if tree >= current_tree
    end

    west = grid[row].slice(0, column).reverse.each_with_object([]) do |tree, ary|
      ary << tree
      break ary if tree >= current_tree
    end

    south = tgrid[column].slice(row + 1, grid.length).each_with_object([]) do |tree, ary|
      ary << tree
      break ary if tree >= current_tree
    end

    north = tgrid[column].slice(0, row).reverse.each_with_object([]) do |tree, ary|
      ary << tree
      break ary if tree >= current_tree
    end

    scores[row][column] = east.size * west.size * south.size * north.size
  end
end

# p grid
p scores

h = grid.size / 2
l = grid.first.size / 2

p scores.flatten.max

# grid = input.each_line.map { |line| line.strip.chars.map(&:to_i) }

# width = grid.first.length
# length = grid.length

# trees = Hash.new { |hash, key| hash[key] = [] }

# grid.each_with_index do |row, y|
#   next if y == 0 || y == length - 1

#   row.each_with_index do |height, x|
#     next if x == 0 || x == width - 1

#     # up
#     dist = y
#     (0..y - 1).reverse_each.with_index do |y1, idx|
#       if grid[y1][x] >= height
#         dist = idx + 1
#         break
#       end
#     end
#     trees[[y, x]] << dist

#     # left
#     dist = x
#     (0..x - 1).reverse_each do |x1|
#       if grid[y][x1] >= height
#         dist = x - x1
#         break
#       end
#     end
#     trees[[y, x]] << dist

#     # down
#     dist = length - 1 - y
#     (y + 1..length - 1).each do |y1|
#       if grid[y1][x] >= height
#         dist = y1 - y
#         break
#       end
#     end
#     trees[[y, x]] << dist

#     # right
#     dist = width - 1 - x
#     (x + 1..width - 1).each do |x1|
#       if grid[y][x1] >= height
#         dist = x1 - x
#         break
#       end
#     end
#     trees[[y, x]] << dist
#   end
# end

# puts trees
# puts trees.values.map { |dist| dist.inject(&:*) }.max

__END__
30373
52512
65332
33549
35390
