require_relative 'PolyTreeNode'

class KnightPathFinder

  attr_reader :root_node
  attr_accessor :considered_positions

  def self.valid_moves(position)
    x, y = position

    lowest_x = x - 2
    if lowest_x < 0
      lowest_x = 0
    end

    highest_x = x + 2
    if highest_x > 7
      highest_x = 7
    end

    moves = []

    if lowest_x >= 0 && highest_x <= 8
      (lowest_x..highest_x).each do |val|
        if (x - val == 2) || (x - val == -2)
          if (y - 1) >=0
            moves << [val, y - 1]
          end
          if (y + 1) <= 7
            moves << [val, y + 1]
          end
        elsif (x - val == 1) || (x - val == -1)
          if (y - 2) >=0
            moves << [val, y - 2]
          end
          if (y + 2) <= 7
            moves << [val, y + 2]
          end
        else
          next
        end
      end
    end
    moves
  end

  def initialize(starting_pos)
    @starting_pos = starting_pos
    @considered_positions = [starting_pos]
    @root_node = PolyTreeNode.new(starting_pos)
    build_move_tree()
  end

  def build_move_tree
    queue = [self.root_node]

    until queue.empty? do
      parent_node = queue.shift
      child_moves = new_move_positions(parent_node.value)
      child_moves.each do |child_move|
        child_node = PolyTreeNode.new(child_move)
        parent_node.add_child(child_node)
        queue << child_node
      end
    end

  end

  def new_move_positions(position)
    new_moves = KnightPathFinder.valid_moves(position)
    new_moves.each do |move|
      new_moves -= [move] if self.considered_positions.include?(move)
    end
    self.considered_positions += new_moves
    new_moves
  end

  def find_path(end_position)
    queue = [self.root_node]

    until queue.empty? do
      current_node = queue.shift
      return trace_back_path(current_node) if current_node.value == end_position
      queue += current_node.children
    end
    nil
  end

  def trace_back_path(node)
    path = [node]
    path_values = []
    until path.first == self.root_node
      path.unshift(path.first.parent)
    end
    path.each { |node| path_values << node.value }
    path_values
  end

end
