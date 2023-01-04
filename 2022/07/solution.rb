require 'minitest/autorun'

path = File.expand_path('input.txt', __dir__)
input = File.read(path)

class Tree
  attr_accessor :root, :current_dir

  def initialize
    @root = Directory.new('/', nil)
    @current_dir = @root
  end

  def change_dir(name)
    self.current_dir = case name
                       when '/'
                         @root
                       when '..'
                         current_dir.parent
                       else
                         find_dir(name)
                       end
  end

  def create_dir(name)
    current_dir.create_dir(name)
  end

  def create_file(name, size)
    current_dir.create_file(name, size)
  end

  def directories
    current_dir.directories
  end

  def files
    current_dir.files
  end

  def find_dir(name)
    raise StandardError, 'that method doesnt exist' unless (dir = directories.find { _1.name == name })

    dir
  end

  def ls
    current_dir.children.map(&:ls).join
  end

  def all_directories
    root.all_directories
  end

  def total_size
    all_directories.select { _1.size < 100_000 }.map(&:size).sum
  end

  def update
    missing_space = 30_000_000 - 27_963_297

    p all_directories.map(&:size).filter { _1 >= missing_space }.min
  end
end

class Node
  attr_accessor :name, :parent

  def initialize(name, parent)
    @name = name
    @parent = parent
  end

  def ls
    puts name
  end
end

class SimpleFile < Node
  attr_accessor :size

  def initialize(name, parent, size)
    @size = size.to_i

    super(name, parent)
  end

  def print
    puts "F: #{name}"
  end
end

class Directory < Node
  attr_accessor :children

  def initialize(name, parent)
    @children = []

    super(name, parent)
  end

  def create_dir(name)
    children << Directory.new(name, self)
  end

  def create_file(name, size)
    children << SimpleFile.new(name, self, size)
  end

  def files
    children.filter { |child| child.instance_of? SimpleFile }
  end

  def directories
    children.filter { |child| child.instance_of? Directory }
  end

  def all_directories
    return self if directories.empty?

    directories.flat_map(&:all_directories).prepend(self)
  end

  def size
    children.map(&:size).sum
  end
end

fs = Tree.new

input.each_line do |line|
  ary = line.split(' ')
  case ary
  in ['$', 'cd', dir]
    fs.change_dir(dir)
  in ['$', 'ls']
    next
  in ['dir', name]
    fs.create_dir(name)
  in [size, name]
    fs.create_file(name, size)
  else
    puts 'WHAT THE FUCK'
  end
end

p '----SOLUTION 1-------'
p fs.total_size

p '----SOLUTION 2-------'
p fs.update

directories = Hash.new { |h, k| h[k] = [] }

current_dir = []

DATA.each_line do |line|
  case line.split
  in [/\d+/ => size, _file]
    directories[current_dir.clone] << size.to_i
  in ['dir', /\w+/ => dir]
    new_dir = current_dir.clone.append(dir)
    directories[current_dir.clone] << directories[new_dir]
  in ['$', 'cd', '..']
    current_dir.pop
  in ['$', 'cd', /.+/ => dir]
    current_dir << dir
  else # ls
  end
end


__END__
$ cd /
$ ls
dir a
14848514 b.txt
8504156 c.dat
dir d
$ cd a
$ ls
dir e
29116 f
2557 g
62596 h.lst
$ cd e
$ ls
584 i
$ cd ..
$ cd ..
$ cd d
$ ls
4060174 j
8033020 d.log
5626152 d.ext
7214296 k