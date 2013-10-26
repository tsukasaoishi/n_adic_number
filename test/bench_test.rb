require 'benchmark'
require File.expand_path('../../lib/n_adic_number/base.rb', __FILE__)

N = NAdicNumber::Base
N.mapping ["0".."9", "a".."z"].map{|r| r.to_a}.flatten

TEST_COUNT = 100000
list = []
TEST_COUNT.times{|n| list << N.new(n)}
sample_list = []
TEST_COUNT.times{|n| sample_list << n.to_s(36)}

Benchmark.bm(7) do |x|
  total1 = x.report("init") do
    TEST_COUNT.times do |n|
      N.new(n)
    end
  end

  total2 = x.report("to_s") do
    list.each do |n|
      n.to_s
    end
  end

  total3 = x.report("to_i") do
    list.each do |n|
      n.to_i
    end
  end

  total4 = x.report("smpl_s") do
    TEST_COUNT.times do |n|
      n.to_s(36)
    end
  end

  total5 = x.report("smpl_i") do
    sample_list.each do |n|
      n.to_i(36)
    end
  end
end
