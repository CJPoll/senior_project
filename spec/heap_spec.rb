require('ruby-debug')
require('./src/heap.rb')
describe "Heap" do

	before :each do
		@heap = Heap.new
	end

	it "should properly initialize" do
		@heap.nil?.should == false
		@heap.size.should == 0
	end

	it "should properly insert a value into an empty heap" do
		@heap.insert 5
		@heap.size.should == 1
		root = @heap.instance_variable_get(:@heap)
		root.size.should == 1
		root[0].value.should == 5
	end

	it "should properly insert a smaller value into a heap" do
		@heap.insert 5
		@heap.insert 3
		root = @heap.instance_variable_get(:@heap)
		root.size.should == 2
		root[0].value.should == 5
		root[1].value.should == 3
	end

	it "should properly insert a larger value into a heap" do
		@heap.insert 3
		@heap.insert 5
		root = @heap.instance_variable_get(:@heap)
		root.size.should == 2
		root[0].value.should == 5
		root[1].value.should == 3
	end

	it "should properly insert several values into a heap" do
		@heap.insert(3).insert(5).insert(7).insert(2).insert(8)
		root = @heap.instance_variable_get(:@heap)
		root.size.should == 5
		root[0].value.should == 8
		root[1].value.should == 7
		root[2].value.should == 5
		root[3].value.should == 2
		root[4].value.should == 3
	end

	it "should properly perform heapsort" do
		@heap.insert(3).insert(5).insert(7).insert(2).insert(8)
		root = @heap.instance_variable_get(:@heap)
		sorted = @heap.heapsort

		sorted[0].value.should == 2
		sorted[1].value.should == 3
		sorted[2].value.should == 5
		sorted[3].value.should == 7
		sorted[4].value.should == 8
	end

	it "should return the max value" do
		@heap.insert(3).insert(5).insert(7).insert(2).insert(8).peek.should == 8
	end

	it "should raise Heap Underflow if peeking into empty heap" do
		expect {@heap.peek}.to raise_error("Heap Underflow")
	end

	it "should raise a Heap underflow exception when trying to pop from an empty heap" do

		expect {@heap.pop}.to raise_error("Heap Underflow")
	end
	
	it "should pop off the max value" do
		@heap.insert(3).insert(5).insert(7).insert(2).insert(8).pop.should == 8
		@heap.size.should == 4
		root = @heap.instance_variable_get(:@heap)
		root[0].value.should == 7
	end

	it "should return the index of a given value" do
		@heap.insert(3).insert(5).insert(7).insert(2).insert(8)
		@heap.index_of(5).should == 2
	end

	it "should modify the priority of a value" do
		@heap.insert(3).insert(5).insert(7).insert(2).insert(8)
		@heap.change_key(9, 7)

		root = @heap.instance_variable_get(:@heap)
		root[0].key.should == 9
	end
end
