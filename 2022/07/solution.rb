require 'minitest/autorun'

path = File.expand_path('input.txt', __dir__)
input = File.read(path)

class Tree
  attr_accessor :root, :current_dir

  def initialize
    @root = Directory.create_root
    @current_dir = @root.name
  end
end

class Node
  attr_accessor :name, :parent

  def initialize(name, parent)
    @name = name
    @parent = parent
  end
end

class SimpleFile < Node
  def initialize(name, parent, size)
    @size = size

    super(name, parent)
  end
end

class Directory < Node
  attr_accessor :children

  def initialize(name, parent)
    @root = []

    super(name, parent)
  end

  def self.create_root
    Directory.new('/', nil)
  end
end

fs = Tree.new

def parse_line(line)
  ary = line.split(' ')
  case ary
  in ['$', 'cd', '..']
    'CHANGE DIR'

  in ['$', 'cd', dir]
    'CHANGE DIR'
  else
    if line.match(/(?<size>\d+)\s(?<name>\w+)/)

    end
  end
end

input.each_line do |_line|
  asdf = []
end

class SolutionTest < Minitest::Test
  def test_parse_command
    assert_equal parse_line('$ cd dir'), 'CHANGE DIR'
  end
end
