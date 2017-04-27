# each node
#
#   -------------
#  |      |      |
#  | val  | next |
#  |      |      |
#   -------------
#

class Node
  attr_accessor :head, :tail

  def initialize(head, tail)
    @head = head
    @tail = tail
  end

  def first
    self.head
  end

  def rest
    self.tail || NullNode.new
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

  def self.cons(*args)
    self.new(args[0], args[1] || NullNode.new)
  end
end

class NullNode
  def nth(*arg); end
  def rest; end
  def map(*arg); end
  def filter(*arg); end
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

p list.first
p list.rest.first # second element

p "0th element: #{list.nth(0)}"
p "3rd element: #{list.nth(3)}"
p "30rd element: #{list.nth(30)}"

upper_list = list.map { |x| x.upcase }

p upper_list
p upper_list.first
p upper_list.nth(2)

filtered_list = list.filter { |x| x[0] == "P" } # Filter only starts with P

p filtered_list
