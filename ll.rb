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
    self.tail
  end

  def nth(n)
    if n == nil
      nil
    elsif n == 0
      self.first
    else
      rest.nth(n-1)
    end
  end

  def map(&block)
    Node.cons(block.call(self.first), self.rest.map(&block))
  end

  def self.cons(val, list)
    self.new(val, list)
  end
end

class NilClass
  def nth(*arg); nil; end
  def map(*arg); nil; end
end

############## DEMO ##########################

list = Node.cons("Plum",
         Node.cons("Pear",
           Node.cons("Apple",
             Node.cons("Orange",
               nil
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

p upper_list.first
p upper_list.nth(2)


