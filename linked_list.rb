# frozen_string_literal: true

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
    else
      @tail.next = entry
    end
    @tail = entry
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
    previous_node = nil
    last_node = nil

    while !current_node.nil? && current_node.data != node_key
      last_node = current_node
      previous_node = current_node
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
  end

  def find(value)
    current = @head
    i = 0
    while current
      return i if current.data == value

      i += 1
      current = current.next
    end
    nil
  end

  def to_s
    each do |entry|
      print "( #{entry.data} ) -> "
    end
    print 'nil'
  end

  def insert_at(value, index)
    temp_node = Node.new(value)
    count = 0
    if @head.nil? || index.zero?
      return prepend(temp_node)
    elsif index > (node_count - 1)
      return append(temp_node)
    else
      current_node = @head
    end

    while count < (index - 1)
      count += 1
      current_node = current_node.next
    end

    temp_node.next = current_node.next
    current_node.next = temp_node
  end

  def remove_at(index)
    count = 0
    current_node = @head
    removal_node = nil
    subsequent_node = nil

    if @head.nil?
      return
    elsif index.zero?
      @head = @head.next
      return current_node
    elsif index > (node_count - 1)
      return pop
    end

    while count < (index - 1)
      count += 1
      current_node = current_node.next
      removal_node = current_node.next
      subsequent_node = removal_node.next
    end

    current_node.next = subsequent_node

    removal_node # returns popped node
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
