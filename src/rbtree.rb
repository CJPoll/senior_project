class RBTree
	class Node
		attr_accessor :key, :value, :left, :right, :parent
		attr_writer :black
		def initialize key = nil, value = key
			@parent = nil
			@black = false
			@key = key
			@value = value
			@left = nil
			@right = nil
		end

		def black?
			@black
		end
	end

	def initialize 
		@@sentinel = Node.new 
		@@sentinel.black = true
		@root = @@sentinel
	end

	def insert key, value = key
		new_node = Node.new key, value
		new_node.right = @@sentinel
		new_node.left = @@sentinel
		if @root == @@sentinel
			@root = new_node
			@root.left = @@sentinel
			@root.right = @@sentinel
		else
			parent = binary_search @root do |parent|
				if parent.key > value and parent.left == @@sentinel
					true
				elsif parent.key <= value and parent.right == @@sentinel
					true	
				elsif parent.key > value
					:greater
				else 
					:less
				end
			end

			insert_node parent, new_node
			cleanup new_node
		end
		@root.black = true

		return self
	end

	def cleanup child
		parent = child.parent
		return if parent == nil
		grandparent = parent.parent
		return if grandparent == nil
		while parent.black? == false
			uncle = nil
			direction = nil
			if parent = grandparent.left
				uncle = grandparent.right
				direction = :left
			else
				uncle = grandparent.left
				direction = :right
			end

			if uncle.black? == false
				parent.black = true
				uncle.black = true
				grandparent.black = false
				child = parent
				parent = child.parent
				grandparent = parent.parent
			else
				if direction == :left
					right_rotation grandparent
				else
					left_rotation grandparent
				end

				parent.black = true
			end
		end
	end

	def binary_search node, &block
		return nil if node == @@sentinel
		comparison = yield(node)
		return node if comparison == true
		return binary_search node.left, &block if comparison == :less
		return binary_search node.right, &block if comparison == :greater
	end

	def preorder_search node, &block
		return nil if node == @@sentinel
		return node if yield(node) == true
		left = preorder_search node.left, &block
		return left if left
		return preorder_search node.right, &block
	end

	def postorder_search node, &block
		return nil if node == @@sentinel
		left = postorder_search node.left, &block
		return left if left
		return node if yield(node) == true
		return postorder_search node.right, &block
	end

	def inorder_search node, &block
		return nil if node == @@sentinel
		left = inorder_search node.left, &block
		return left if left
		return node if yield(node) == true
		return inorder_search node.right, &block
	end

	def left_rotation grandparent
		parent = grandparent.right

		grandparent.right = parent.left
		parent.left.parent = grandparent unless parent.left == @@sentinel
		parent.parent = grandparent.parent
		if grandparent.parent == nil
			@root = parent 
		elsif grandparent = grandparent.parent.left
			grandparent.parent.left = parent
		else
			grandparent.parent.right = y
		end

		parent.left = grandparent
		grandparent.parent = parent

		return parent
	end

	def right_rotation grandparent
		parent = grandparent.left
		grandparent.left = parent.right
		parent.right.parent = grandparent unless parent.right == @@sentinel
		parent.parent = grandparent.parent

		if grandparent.parent == nil
			@root = parent 
		elsif grandparent = grandparent.parent.left
			grandparent.parent.left = parent
		else
			grandparent.parent.right = y
		end

		parent.right = grandparent
		grandparent.parent = parent

		return parent
	end

	def insert_node parent, child
		child.parent = parent

		return nil unless parent
		parent.left = child if child.key < parent.key
		parent.right = child if child.key >= parent.key

	end

	def self.sentinel
		@@sentinel
	end
end
