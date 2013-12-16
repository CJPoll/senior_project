require('./src/priority_queue.rb')
describe "Priority Queue" do

	before :each do
		@queue = PriorityQueue.new
	end

	it "should properly initialize" do
		@queue.nil?.should == false
		@queue.size.should == 0
	end

	it "should insert a KV pair into the queue" do
		@queue.insert(5, :hello)
		@queue.size.should == 1
	end

	it "should peek at the max in the queue" do
		@queue.insert(5, :hello).insert(3, :hi).insert(2, :bye)
		@queue.peek.should == :hello
		@queue.size.should == 3
	end

	it "should pop off the max in the queue do" do 
		@queue.insert(5, :hello).insert(3, :hi).insert(2, :bye)
		@queue.pop.should == :hello
		@queue.size.should == 2
	end

	it "should change the priority of a value in the queue" do
		@queue.insert(5, :hello).insert(3, :hi).insert(2, :bye)
		@queue.change_priority(7, :hi)

		@queue.pop.should == :hi
		@queue.pop.should == :hello
		@queue.pop.should == :bye
	end
end
