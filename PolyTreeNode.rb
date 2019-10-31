class PolyTreeNode

  attr_reader :value, :parent, :children

  def initialize(value)
    @value = value
    @parent = nil
    @children = []
  end

  def parent=(parent_node)
    if self.parent != nil
      self.parent.children.delete(self)
    end
    @parent = parent_node
    if parent_node != nil
      self.parent.children << self
    end
  end

  def add_child(child_node)
    child_node.parent = self
  end

  def remove_child(child_node)
    if child_node.parent == nil
      raise "This node is not a child."
    else
      child_node.parent = nil
    end
  end

  def dfs(target_value)
    return self if self.value == target_value

    children.each do |child|
      target_node = child.dfs(target_value)
      return target_node unless target_node.nil?
    end
    nil
  end

  def bfs(target_value)
    queue = [self]
    until queue.empty?
      current_node = queue.shift
      return current_node if current_node.value == target_value
      queue += current_node.children
    end
    nil
  end
end
