class Heap

	class Node
		include Comparable
		attr_accessor :key, :value
		def initialize key, value = key
			@key = key
			@value = value
		end

		def <=> other
			self.key <=> other.key
		end
	end

	attr_reader :size
	def initialize
		@heap = []
		@size = 0
	end

	def insert key, value = key
		node = Node.new key, value
		@heap << node
		@size += 1
		build_heap
		self
	end

	def heapsort
		index = @size - 1
		build_heap
		while index > 0
			swap = @heap[0]
			@heap[0] = @heap[index]
			@heap[index] = swap
			@size -= 1
			heapify 0 #if index > 3
			index -= 1
		end

		@heap
	end

	def peek
		raise "Heap Underflow" if @size < 1
		@heap[0].value
	end

	def pop
		raise "Heap Underflow" if @size < 1
		max = @heap[0]
		@heap[0] = @heap[@size - 1]
		@size -= 1
		heapify 0
		return max.value
	end

	def index_of value
		@heap.index do |element|
			element.value == value
		end
	end

	def change_key key, value
		index = index_of value
		@heap[index].key = key
		while index > 0 and @heap[parent index] < @heap[index]
			swap = @heap[parent index]
			@heap[parent index] = @heap[index]
			@heap[index] = swap
			index = parent index
		end
		self
	end

	private

	def heapify  root_index 
		largest = nil
		left = left root_index
		right = right root_index

		if left < @size and @heap[left] > @heap[root_index]
			largest = left
		else 
			largest = root_index
		end

		largest = right if right < @size and @heap[right] > @heap[largest]

		if largest != root_index
			swap = @heap[root_index]
			@heap[root_index] = @heap[largest]
			@heap[largest] = swap
			heapify largest
		end

	end

	def left index
		(index * 2) + 1
	end

	def right index
		(index * 2) + 2
	end

	def parent index
		(index - 1) / 2
	end

	def build_heap 
		index = @size / 2
		while index >= 0
			heapify index
			index -= 1
		end
	end

end
