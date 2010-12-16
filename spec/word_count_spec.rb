$LOAD_PATH.unshift File.join(File.dirname(__FILE__),'..','lib')

require 'regular_word_count'
describe 'Shak' do
  before(:each) do
    @word_counter = WordCount.new
  end

  def count(str)
    @word_counter.count str
  end

  it "return a map of words and count" do
    count("akka rocks").should == {'akka' => 1, 'rocks' => 1}
  end

  it "should ignore case" do
    count("AKKA ROCKS").should == {'akka' => 1, 'rocks' => 1}
  end

  it "should ignore ponctuation" do
    count("AKKA? ROCKS!!!").should == {'akka' => 1, 'rocks' => 1}
  end

  it "should ignore all sorts of special characters" do
    count("!!  (AKKA)? [],;*::ROCKS!!!").should == {'akka' => 1, 'rocks' => 1}
  end

  it "should separte words of special charcters" do
    count("c'est").should == {"c'est" => 1}
  end

  it "should ignore multiple parenthesis" do
    count("'''wrong'''").should == {'wrong' => 1}
  end
end

