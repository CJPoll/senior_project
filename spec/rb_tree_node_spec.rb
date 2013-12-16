require('./src/rbtree.rb')
describe "Red Black Tree Node" do

	before :each do
		@node = RBTree::Node.new
	end

	it "should properly initialize with default values" do
		@node.nil?.should == false
		@node.key.nil?.should == true
		@node.value.nil?.should == true
		@node.black?.should == true
	end

	it "should properly initialize with only a key" do
		@node = RBTree::Node.new 5

		@node.key.should == 5
		@node.value.should == 5
		@node.black?.should == true
	end

	it "should properly initialize with key & value" do
		@node = RBTree::Node.new 4, 5

		@node.key.should == 4
		@node.value.should == 5
		@node.black?.should == true
	end
end
