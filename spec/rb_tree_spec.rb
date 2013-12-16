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
		
		root.right.key.should == 6
		root.right.parent.should == root
		root.left.should == sentinel
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

		debugger

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
		sentinel = RBTree::Node.new

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

		@tree.left_rotation(grandparent, sentinel).should == parent

	end
end
