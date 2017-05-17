# each node
#
#   -------------
#  |      |      |
#  | val  | next |
#  |      |      |
#   -------------
#

require 'byebug'

class Node
  attr_accessor :head, :tail

  def initialize(head, tail)
    @head = head
    @tail = tail
  end

  def rest
    tail || NullNode.new
  end

  def first
    self.head
  end

  def last
    (self.tail.rest) ? self.rest.last : self.head
  end

  def nth(n)
    n == 0 ? self.first : rest.nth(n-1)
  end

  def map(&block)
    Node.cons(block.call(self.first), self.rest.map(&block))
  end

  def filter(&block)
    if block.call(self.first)
      Node.cons(self.first, self.rest.filter(&block))
    else
      self.rest.filter(&block)
    end
  end

  def reduce(start = nil, &block)
    self.rest.reduce(block.call(start || 0, self.first), &block)
  end

  def inspect
    "#{self.head} #{self.rest.print}"
  end

  def print
    "-> #{self.head} #{self.rest.print}"
  end

  def self.cons(*args)
    self.new(args[0], args[1] || NullNode.new)
  end
end

class NullNode
  def nth(*arg); end
  def rest; end
  def map(*arg); end
  def filter(*arg); end
  def reduce(*arg); arg[0]; end
  def print; end
  def last; end
end

############## DEMO ##########################

list = Node.cons("Plum",
         Node.cons("Pear",
           Node.cons("Apple",
             Node.cons("Orange",
               Node.cons("Pineapple")
             )
           )
         )
       )

puts "List: #{list.inspect}"
puts "First item: #{list.first}"
puts "Second item: #{list.rest.first}"
puts "Last item: #{list.last}"
puts "\n"
puts "0th element: #{list.nth(0)}"
puts "3rd element: #{list.nth(3)}"
puts "30rd element: #{list.nth(30)}"
puts "\n"

upper_list = list.map { |x| x.upcase }

puts "Upper list: #{upper_list.inspect}"
puts "Upper list first item: #{upper_list.first}"
puts "Upper list second item: #{upper_list.nth(2)}"
puts "\n"

filtered_list = list.filter { |x| x[0] == "P" } # Filter only starts with P

puts "Filtered list: #{filtered_list.inspect}"

numeric_list = Node.cons(1,
                 Node.cons(2,
                   Node.cons(3)))

sum = numeric_list.reduce { |prev, cur| prev + cur }
puts "Sum: #{sum}"

bigger_numeric_list = Node.cons(1,
                       Node.cons(2,
                         Node.cons(3,
                           Node.cons(4))))

sum = bigger_numeric_list.reduce(&:+)
puts "Sum: #{sum}"
