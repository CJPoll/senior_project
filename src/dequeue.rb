class Dequeue
	def initialize
		@list = DoublyLinkedList.new
	end

	def size
		@list.size
	end

	def enqueue_head value
		@list.push_head value
	end

	def enqueue_tail value
		@list.push_tail value
	end

	def dequeue_head
		@list.pop_head
	end

	def dequeue_tail
		@list.pop_tail
	end
end
