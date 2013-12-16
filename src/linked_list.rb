class LinkedList
	class Node
		attr_accessor :next
		attr_reader :value

		def initialize value
			@value = value
			@next = nil
		end

	end

	attr_reader :size
	def initialize
		@size = 0
		@head = Node.new nil
	end

	def insert value, index
		node = Node.new value
		insert_node node, index
		@size += 1
	end

	def push_tail value
		insert value, @size
	end

	def push_head value
		insert value, 0
	end

	def retrieve index
		prev = traverse_list @head, index
		prev.next.value
	end

	def remove index
		remove_node index
		@size -= 1
	end

	def peek
		traverse_list(@head, 1).value
	end

	def pop
		raise "Out of bounds exception" if @size == 0 
		value = retrieve 0
		remove 0
		value
	end

	private

	def traverse_list node, index
		raise "Out of bounds exception" if index < 0 || index > @size
		return node if index == 0
		return traverse_list node.next, index - 1
	end

	def insert_node node, index
		prev = traverse_list @head, index
		node.next = prev.next
		prev.next = node
	end

	def remove_node index
		prev = traverse_list @head, index
		prev.next = prev.next.next
	end
end
