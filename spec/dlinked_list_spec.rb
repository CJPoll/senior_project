require('./src/dlinked_list.rb')
require('ruby-debug')
describe "DoublyLinkedList" do
	before :each do
		@list = DoublyLinkedList.new
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

	it "should push a value onto an empty list" do
		@list.push_head 5

		@list.instance_variable_get(:@head).next.value.should == 5
		@list.instance_variable_get(:@tail).prev.value.should == 5
		@list.size.should == 1
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

		@list.pop_head.should == 5
		@list.retrieve(0).should == 4
		@list.size.should == 2
	end

	it "should show the tail value & remove it from the list" do
		@list.insert 5, 0
		@list.insert 4, 1
		@list.insert 3, 2

		@list.pop_tail.should == 3
		@list.retrieve(0).should == 5
		@list.retrieve(1).should == 4
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

	it "should raise an exception for trying to pop_head an empty list" do
		expect {@list.pop_head}.to raise_error("Out of bounds exception")
	end

	it "should properly enumerate through the LinkedList" do
		@list.push_head(5).push_head(6).push_head(7)

		numbers = []
		@list.each do |number|
			numbers << number
		end

		numbers.should == [7, 6, 5]
	end

	it "should be able to find a number" do
		@list.push_head(5).push_head(6).push_head(7)
		number = @list.find {|number| number == 6}
		number.should == 6
	end

	it "should be able to sort the linked list and return the values as an array" do
		@list.push_head(6).push_head(5).push_head(7).sort.should == [5,6,7]
	end

	it "should be able to sort the linked list internally" do
		@list.push_head(6).push_head(5).push_head(7)
		@list.bubble_sort!

		@list.pop_head.should == 5
		@list.pop_head.should == 6
		@list.pop_head.should == 7
	end

	it "should know if it contains a node" do
		@list.push_head(6).push_head(5).push_head(7)
		@list.contains?(5).should == true
	end
end
