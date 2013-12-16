require('./src/stack.rb')
describe "Stack" do

	before :each do
		@stack = Stack.new
	end

	it "should create and properly initialize a stack" do
		@stack.nil?.should == false
		@stack.size.should == 0
		@stack.instance_variable_get(:@list).nil?.should == false
	end

	it "should properly insert a new item into an empty stack" do
		@stack.push 5
		@stack.instance_variable_get(:@list).peek.should == 5
		@stack.size.should == 1
	end

	it "should properly push a new item onto a non-empty stack" do
		@stack.push 5
		@stack.push 4
		@stack.push 3

		@stack.size.should == 3

		@stack.instance_variable_get(:@list).peek.should == 3
		@stack.instance_variable_get(:@list).retrieve(1).should == 4
		@stack.instance_variable_get(:@list).retrieve(2).should == 5
	end

	it "should return the top value without removing it" do
		@stack.push 5
		@stack.push 4
		@stack.push 3

		@stack.peek.should == 3
	end

	it "should return the top value and remove it" do
		@stack.push 5
		@stack.push 4
		@stack.push 3

		@stack.pop.should == 3
		@stack.size.should == 2
	end
end
