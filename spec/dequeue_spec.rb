require('./src/dequeue.rb')
describe "Dequeue" do

	before :each do
		@dequeue = Dequeue.new
	end

	it "should properly initialize" do
		@dequeue.nil?.should == false
		@dequeue.size.should == 0
	end

	it "should properly enqueue an item to the head" do
		@dequeue.enqueue_head 5
		@dequeue.instance_variable_get(:@list).peek.should == 5
	end

	it "should properly enqueue an item to the head of a non-empty dequeue" do
		@dequeue.enqueue_head 5
		@dequeue.enqueue_head 4
		@dequeue.enqueue_head 3

		list = @dequeue.instance_variable_get(:@list)

		list.pop_head.should == 3
		list.pop_head.should == 4
		list.pop_head.should == 5
	end

	it "should properly enqueue an item to the tail" do
		@dequeue.enqueue_tail 5
		@dequeue.enqueue_tail 4
		@dequeue.enqueue_tail 3

		list = @dequeue.instance_variable_get(:@list)

		list.pop_tail.should == 3
		list.pop_tail.should == 4
		list.pop_tail.should == 5
	end

	it "should properly deqeuue an item from the head" do
		@dequeue.enqueue_head 5
		@dequeue.enqueue_head 4
		@dequeue.enqueue_head 3

		@dequeue.dequeue_head.should == 3
		@dequeue.dequeue_head.should == 4
		@dequeue.dequeue_head.should == 5
	end

	it "should properly dequeue an item from the tail" do
		@dequeue.enqueue_head 5
		@dequeue.enqueue_head 4
		@dequeue.enqueue_head 3

		@dequeue.dequeue_tail.should == 5
		@dequeue.dequeue_tail.should == 4
		@dequeue.dequeue_tail.should == 3
	end
end
