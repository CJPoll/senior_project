require('./src/rbtree.rb')
require('ruby-debug')
describe "Red Black Tree" do

	before :each do
		@tree = RBTree.new
	end

	it "should properly initialize" do
		@tree.nil?.should == false
		sentinel = RBTree.sentinel
		root = @tree.instance_variable_get(:@root)
		root.nil?.should == false
		root.should == sentinel
	end

	it "should properly insert a node into an empty tree" do
		@tree.insert 5
		root = @tree.instance_variable_get(:@root)
		root.key.should == 5
		root.value.should == 5
		root.black?.should == true
	end

	it "should return the tree after an insert" do
		returned_value = @tree.insert 5
		returned_value.should == @tree
	end

	it "should find a node in root position using preorder_search" do
		@tree.insert 5

		root = @tree.instance_variable_get(:@root)
		expected  = 5
		@tree.preorder_search(root) do |node|
			node.key == expected
		end.should == root
	end

	it "should be able to tell a tree of size 1 doesn't contain a value using preorder_search" do
		@tree.insert 5

		root = @tree.instance_variable_get(:@root)
		expected = 6
		@tree.preorder_search(root) do |node| 
			node.key == expected
		end.should == nil
	end

	it "should find a node in root position using postorder_search" do
		@tree.insert 5

		root = @tree.instance_variable_get(:@root)
		expected  = 5
		@tree.postorder_search(root) do |node|
			node.key == expected
		end.should == root
	end

	it "should be able to tell a tree of size 1 doesn't contain a value using postorder_search" do
		@tree.insert 5

		root = @tree.instance_variable_get(:@root)
		expected = 6
		@tree.postorder_search(root) do |node| 
			node.key == expected
		end.should == nil
	end

	it "should find a node in root position using inorder_search" do
		@tree.insert 5

		root = @tree.instance_variable_get(:@root)
		expected  = 5
		@tree.inorder_search(root) do |node|
			node.key == expected
		end.should == root
	end

	it "should be able to tell a tree of size 1 doesn't contain a value using inorder_search" do
		@tree.insert 5

		root = @tree.instance_variable_get(:@root)
		expected = 6
		@tree.inorder_search(root) do |node| 
			node.key == expected
		end.should == nil
	end

	it "should find a node in root position using binary_search" do
		@tree.insert 5

		root = @tree.instance_variable_get(:@root)
		expected  = 5
		@tree.binary_search(root) do |node|
			if node.key == expected
				true
			elsif node.key < expected
				:less
			else
				:greater
			end
		end.should == root
	end

	it "should be able to tell a tree of size 1 doesn't contain a value using binary_search" do
		@tree.insert 5

		root = @tree.instance_variable_get(:@root)
		expected = 6
		@tree.binary_search(root) do |node| 
			if node.key == expected
				true
			elsif node.key < expected
				:less
			else
				:greater
			end
		end.should == nil
	end

	it "should properly insert a node greater than root" do
		@tree.insert(5).insert(6)

		root = @tree.instance_variable_get(:@root)
		sentinel = RBTree.sentinel
		
		root.black?.should == true

		root.right.key.should == 6
		root.right.black?.should == false
		root.right.parent.should == root
		root.left.should == sentinel
		root.left.black?.should == true
	end

	it "should properly insert a node less than root" do
		@tree.insert(5).insert(4)

		root = @tree.instance_variable_get(:@root)
		sentinel = RBTree.sentinel

		root.left.key.should == 4
		root.left.parent.should == root
		root.right.should == sentinel
	end

	it "should properly do a left rotation (RRb)" do
		sentinel = RBTree.sentinel

		grandparent = RBTree::Node.new 5
		grandparent.black = true

		parent = RBTree::Node.new 6
		parent.black = false

		child = RBTree::Node.new 7
		child.black = false

		grandparent.left = sentinel
		parent.left = sentinel
		child.left = sentinel
		child.right = sentinel

		@tree.insert_node grandparent, parent
		@tree.insert_node parent, child 

		grandparent.right.should == parent
		parent.right.should == child

		grandparent.left.should == sentinel
		parent.left.should == sentinel
		child.left.should == sentinel
		child.right.should == sentinel

		@tree.left_rotation(grandparent).should == parent

		grandparent.parent.should == parent
		parent.parent.should == nil
		child.parent.should == parent
		grandparent.left.should == sentinel
		grandparent.right.should == sentinel
		child.left.should == sentinel
		child.right.should == sentinel
	end

	it "should properly do a left rotation (RLb)" do
		sentinel = RBTree.sentinel

		grandparent = RBTree::Node.new 5
		grandparent.black = true

		parent = RBTree::Node.new 7
		parent.black = false

		child = RBTree::Node.new 6
		child.black = false

		grandparent.left = sentinel
		parent.right = sentinel
		child.left = sentinel
		child.right = sentinel

		@tree.insert_node grandparent, parent
		@tree.insert_node parent, child 

		grandparent.right.should == parent
		parent.left.should == child

		grandparent.left.should == sentinel
		parent.right.should == sentinel
		child.left.should == sentinel
		child.right.should == sentinel

		@tree.left_rotation(grandparent).should == parent
		parent.left.should == grandparent
		grandparent.right.should == child
		parent.parent.nil?.should == true
		parent.left.should == grandparent

		child.left.should == sentinel
		child.right.should == sentinel
		grandparent.left.should == sentinel
		parent.right.should == sentinel
	end

	it "should properly do a right rotation (LLb)" do
		sentinel = RBTree.sentinel

		grandparent = RBTree::Node.new 7
		grandparent.black = true

		parent = RBTree::Node.new 6
		parent.black = false

		child = RBTree::Node.new 5
		child.black = false

		grandparent.right = sentinel
		parent.right = sentinel
		child.left = sentinel
		child.right = sentinel

		@tree.insert_node grandparent, parent
		@tree.insert_node parent, child

		grandparent.left.should == parent
		parent.left.should == child

		grandparent.right.should == sentinel
		parent.right.should == sentinel
		child.left.should == sentinel
		child.right.should == sentinel

		@tree.right_rotation(grandparent).should == parent

		grandparent.left.should == sentinel
		grandparent.right.should == sentinel

		parent.left.should == child
		grandparent.parent.should == parent
		parent.right.should == grandparent
		parent.parent.should == nil
	end

	it "should properly do a right rotation (LRb)" do
		sentinel = RBTree.sentinel

		grandparent = RBTree::Node.new 7
		grandparent.black = true

		parent = RBTree::Node.new 5
		parent.black = false

		child = RBTree::Node.new 6
		child.black = false

		grandparent.right = sentinel
		parent.left = sentinel
		child.left = sentinel
		child.right = sentinel

		@tree.insert_node grandparent, parent
		@tree.insert_node parent, child

		grandparent.left.should == parent
		parent.right.should == child

		grandparent.right.should == sentinel
		parent.left.should == sentinel
		child.left.should == sentinel
		child.right.should == sentinel

		@tree.right_rotation(grandparent).should == parent

		grandparent.left.should == child
		parent.right.should == grandparent

		parent.parent.should == nil
		grandparent.parent.should == parent

		child.left.should == sentinel
		child.right.should == sentinel
		grandparent.right.should == sentinel
		parent.left.should == sentinel
	end
end
