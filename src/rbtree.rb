class RBTree
	class Node
		attr_accessor :key, :value, :black, :left, :right, :parent
		def initialize key = nil, value = key
			@parent = nil
			@black = true
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
		end

		return self
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
		@root = parent if grandparent.parent == nil

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
