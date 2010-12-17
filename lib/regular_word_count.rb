class WordCount
  def count(string)
    string.split.inject(Hash.new 0) { |h, word| countWord h, word }
  end

  def countWord(h, word)
    w = normalize word
    h[w] += 1 unless w.empty?
    h
  end


  PONCTUATION = /[.,'":;*\[\]!?()\/\\]+/.source
  def normalize(word)
    word.downcase.gsub(/\B#{PONCTUATION}/, '').gsub(/#{PONCTUATION}\B/, '').strip
  end
end

if $PROGRAM_NAME == __FILE__
  file = File.join(File.dirname(__FILE__), 'shakespeare.txt')
  require 'pp'
  f = IO.read(file)
  puts "starting"
  start = Time.now
  result = WordCount.new.count(f)
  finish = Time.now
  puts ">> All over: Just to say we used any computed value: #{result['shakespeare']}"
  puts ">> Total time: #{finish - start}s"
end