class Stack
	def initialize
		@size = 0
		@list = DoublyLinkedList.new
	end

	def push value
		@list.push_head value
	end

	def size
		@list.size
	end

	def peek
		@list.peek
	end

	def pop
		@list.pop_head
	end
end
