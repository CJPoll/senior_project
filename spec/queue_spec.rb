require('./src/queue.rb')
describe "Queue" do

	before :each do
		@queue = Queue.new
	end

	it "should properly create & initialize a queue" do
		@queue.nil?.should == false
		@queue.instance_variable_get(:@list).nil?.should == false
		@queue.size.should == 0
	end

	it "should properly enqueue an item when empty" do
		@queue.enqueue 1

		@queue.instance_variable_get(:@list).peek.should == 1
		@queue.size.should == 1
	end

	it "should properly enqueue an item when not empty" do
		@queue.enqueue 1
		@queue.enqueue 2

		@queue.instance_variable_get(:@list).pop_tail.should == 1
		@queue.instance_variable_get(:@list).pop_tail.should == 2
	end

	it "should properly dequeue an item" do
		@queue.enqueue 1
		@queue.enqueue 2

		@queue.dequeue.should == 1
		@queue.size.should == 1
		@queue.dequeue.should == 2
		@queue.size.should == 0
	end
end
