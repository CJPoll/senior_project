class Queue
	def initialize
		@list = DoublyLinkedList.new
		@size = 0
	end

	def enqueue value
		@list.push_head value
	end

	def dequeue
		@list.pop_tail
	end

	def size
		@list.size
	end

end
