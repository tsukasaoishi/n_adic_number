require 'benchmark'
require File.expand_path('../../lib/n_adic_number/base.rb', __FILE__)

N = NAdicNumber::Base
N.mapping ["0".."9", "a".."z"].map{|r| r.to_a}.flatten

class NumberOfBase62 < NAdicNumber::Base
    mapping ["0".."9", "A".."Z", "a".."z"].map{|r| r.to_a}.flatten
end

a = NumberOfBase62.new("aaaaa")
p a.to_i
p a.to_s


TEST_COUNT = 100000
sample_list = []
TEST_COUNT.times{|n| sample_list << n.to_s(36)}
int_list = []
TEST_COUNT.times{|n| int_list << N.new(n)}
str_list = sample_list.map{|n| N.new(n)}

Benchmark.bm(10) do |x|
  x.report("init_i") do
    TEST_COUNT.times do |n|
      N.new(n)
    end
  end

  x.report("init_s") do
    sample_list.each do |n|
      N.new(n)
    end
  end

  x.report("to_s_from_s") do
    str_list.each do |n|
      n.to_s
    end
  end

  x.report("to_s_from_i") do
    int_list.each do |n|
      n.to_s
    end
  end

  x.report("to_i_from_s") do
    str_list.each do |n|
      n.to_i
    end
  end

  x.report("to_i_from_i") do
    int_list.each do |n|
      n.to_i
    end
  end

  x.report("smpl_s") do
    TEST_COUNT.times do |n|
      n.to_s(36)
    end
  end

  x.report("smpl_i") do
    sample_list.each do |n|
      n.to_i(36)
    end
  end
end
