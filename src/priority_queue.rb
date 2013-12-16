class PriorityQueue
	attr_reader :size
	def initialize
		@heap = Heap.new
	end

	def insert priority, value
		@heap.insert priority, value
	end

	def size
		@heap.size
	end

	def peek
		@heap.peek
	end

	def pop
		@heap.pop
	end

	def change_priority key, value
		@heap.change_key key, value
	end
end
