require 'benchmark'
a = 200000

Benchmark.bmbm(10) do |b|
  b.report('any:     ') { a.times do; true if @replies.any?       ; end }
  b.report('empty:   ') { a.times do; true unless @replies.empty? ; end }
  b.report('length:  ') { a.times do; true if @replies.length > 1 ; end }
end
