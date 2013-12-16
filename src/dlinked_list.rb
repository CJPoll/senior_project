class DoublyLinkedList
	include Enumerable
	class Node
		include Comparable
		attr_accessor :next, :prev
		attr_reader :value

		def initialize value = nil
			@value = value
			@next = nil
			@prev = nil
		end

		def to_s
			"\nVALUE: #{@value}; NEXT: #{@next}"#, PREV: #{@prev}"
		end

		def <=> other
			@value <=> other
		end

	end

	def to_s
		"HEAD: #{@head}"
	end

	attr_reader :size
	def initialize
		@size = 0
		@head = Node.new
		@tail = Node.new

		@head.next = @tail
		@tail.prev = @head
	end

	def insert value, index
		node = Node.new value
		insert_node node, index
		@size += 1
		self
	end

	def push_tail value
		insert value, @size
		self
	end

	def push_head value
		insert value, 0
	end

	def retrieve index
		prev = traverse_list index
		prev.next.value
	end

	def remove index
		value = remove_node index
		@size -= 1
		self
	end

	def peek
		traverse_list(1).value
	end

	def pop_head
		raise "Out of bounds exception" if @size == 0 
		value = retrieve 0
		remove 0
		value
	end

	def pop_tail
		raise "Out of bounds exception" if @size == 0 
		value = retrieve @size - 1
		remove @size - 1
		value
	end

	def each
		node = @head
		while node.next != @tail
			yield node.next.value
			node = node.next
		end
	end

	def bubble_sort!
		swap_occurred = true
		while swap_occurred
			swap_occurred = false
			node = @head.next
			while node and node.next != @tail 
				if comparison node, node.next
					swap_occurred = true 
				else
					node = node.next 
				end
			end
		end
	end

	def contains? value
		value == self.find {|stored_value| stored_value == value}
	end

	private

	def traverse_list index
		raise "Out of bounds exception" if index < 0 or index > @size
		prev = nil

		if index <= @size / 2 
			prev = @head
			while (index > 0)
				prev = prev.next
				index -= 1
			end
		else
			following = @tail
			count = @size + 1
			while count > index
				following = following.prev
				count -= 1
			end

			prev = following
		end

		return prev
	end

	def insert_node node, index
		prev = traverse_list index
		following = prev.next
		node.next = following
		prev.next = node
		node.prev = prev
		following.prev = node
	end

	def remove_node index
		prev = traverse_list index
		removing = prev.next
		prev.next = removing.next
		removing.next = nil
	end

	def swap left, right
		prev = left.prev
		last = right.next

		left.prev = right
		left.next = last

		right.prev = prev
		right.next = left

		prev.next = right
		last.prev = left
	end

	def comparison node, next_node
		if  node.value > next_node.value
			swap node, node.next 
			return true
		end
		return false
	end
end
