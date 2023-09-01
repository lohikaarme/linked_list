class LinkedList
  include Enumerable
  attr_accessor :head, :tail

  def initialize
    @head = nil
    @tail = nil
  end

  def prepend(entry)
    if @head.nil?
      @head = entry
      @tail = entry
    else
      entry.next = @head
      @head = entry
    end
  end

  def append(entry)
    if @head.nil?
      @head = entry
      @tail = entry
    else
      @tail.next = entry
      @tail = entry
    end
  end

  def each
    return nil if @head.nil?

    entry = @head
    until entry.nil?
      yield entry
      entry = entry.next
    end
  end

  def display_head
    p @head.data
  end

  def display_tail
    p @tail.data
  end

  def node_count
    count = 0
    current_node = @head
    while current_node
      count += 1
      current_node = current_node.next
    end
    count
  end

  def at(index)
    count = 0
    current_node = @head
    while current_node
      return current_node.data if index == count

      count += 1
      current_node = current_node.next
    end
  end

  def pop # rubocop:disable Metrics/AbcSize
    return if @head.nil?

    nodes = node_count
    if nodes == 1
      @head = nil
      @tail = nil
    end

    node_key = at(node_count - 1)
    current_node = @head
    previous_node = nil # rubocop:disable Lint/UselessAssignment
    last_node = nil

    while !current_node.nil? && current_node.data != node_key
      last_node = current_node
      previous_node = current_node # rubocop:disable Lint/UselessAssignment
      current_node = current_node.next
    end

    return if current_node.nil?

    @tail = previous_node
    previous_node.next = current_node.next
    last_node # returns popped node
  end

  def contains?(value)
    current = @head
    while current
      return true if current.data == value
      current = current.next
    end
    false
    # each do |entry|
    #   return true if entry.data == value
    # end
    # false
  end

end

class Node
  attr_accessor :next, :data

  def initialize(data)
    @next = nil
    @data = data
  end

  def value
    p @data
  end

  def next_node
    p @next
  end
end

list = LinkedList.new
node1 = Node.new(4)
node2 = Node.new(45)
node3 = Node.new(46)
list.append(node1)
list.append(node2)
list.append(node3)
list.contains?(4)

list.contains?(5)
