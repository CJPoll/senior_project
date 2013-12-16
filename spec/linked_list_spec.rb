require('./src/linked_list.rb')
describe "LinkedList" do
	before :each do
		@list = LinkedList.new
	end

	it "should create a list and properly initialize it" do
		@list.nil?.should == false
		@list.size.should == 0
		@list.instance_variable_get(:@head).nil?.should == false
	end

	it "should properly insert a new node into an empty list" do
		@list.insert 5, 0
		@list.instance_variable_get(:@head).next.value.should == 5
		@list.size.should == 1
	end

	it "should properly insert a new node at the end of a non-empty list" do
		@list.insert 5, 0
		@list.insert 4, 1

		@list.instance_variable_get(:@head).next.value.should == 5
		@list.instance_variable_get(:@head).next.next.value.should == 4
		@list.size.should == 2
	end

	it "should properly insert a new node in between previously existing nodes" do
		@list.insert 5, 0
		@list.insert 3, 1
		@list.insert 4, 1

		@list.instance_variable_get(:@head).next.next.value.should == 4
		@list.instance_variable_get(:@head).next.next.next.value.should == 3
		@list.size.should == 3
	end

	it "should properly retrieve a value from the list" do
		@list.insert 5, 0
		@list.insert 4, 1
		@list.insert 3, 2

		@list.retrieve(0).should == 5
		@list.retrieve(1).should == 4
		@list.retrieve(2).should == 3

		@list.size.should == 3
	end

	it "should properly remove a value from the list" do
		@list.insert 5, 0
		@list.insert 4, 1
		@list.insert 3, 2

		@list.remove(0)

		@list.retrieve(0).should == 4

		@list.size.should == 2
	end

	it "should push a value to the head of the list" do
		@list.insert 5, 0
		@list.insert 4, 1
		@list.insert 3, 2

		@list.push_head 6

		@list.retrieve(0).should == 6
		@list.retrieve(1).should == 5

		@list.size.should == 4
	end

	it "should push a value to the end of a list" do
		@list.insert 5, 0
		@list.insert 4, 1
		@list.insert 3, 2

		@list.push_tail 2

		@list.retrieve(3).should == 2

		@list.size.should == 4
	end

	it "should show the head value without removing it" do
		@list.insert 5, 0
		@list.insert 4, 1
		@list.insert 3, 2
		
		@list.peek.should == 5

		@list.retrieve(0).should == 5
		@list.size.should == 3
	end

	it "should show the head value & remove it from the list" do
		@list.insert 5, 0
		@list.insert 4, 1
		@list.insert 3, 2

		@list.pop.should == 5
		@list.retrieve(0).should == 4
		@list.size.should == 2
	end

	it "should raise an exception for trying to insert to a negative index" do
		expect {@list.insert(1, -1)}.to raise_error("Out of bounds exception")
	end

	it "should raise an exception for trying to insert to an index larger than size" do
		expect {@list.insert(1, 1)}.to raise_error("Out of bounds exception")
	end

	it "should raise an exception for trying to retrieve a negative index" do
	 	expect{@list.retrieve(-1)}.to raise_error("Out of bounds exception")
	end

	it "should raise an exception for trying to retrieve an index larger than size" do
		expect {@list.retrieve(1)}.to raise_error("Out of bounds exception")
	end

	it "should raise an exception for trying to remove a negative index" do
		expect {@list.remove(-1)}.to raise_error("Out of bounds exception")
	end

	it "should raise an exception for trying to remove an index greater than size" do
		expect {@list.remove(1)}.to raise_error("Out of bounds exception")
	end

	it "should raise an exception for trying to peek an empty list" do
		expect {@list.peek}.to raise_error("Out of bounds exception")
	end

	it "should raise an exception for trying to pop an empty list" do
		expect {@list.pop}.to raise_error("Out of bounds exception")
	end
end
