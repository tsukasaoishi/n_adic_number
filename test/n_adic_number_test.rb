# coding: utf-8

require_relative './test_helper'

class TestNAdicNumner < MiniTest::Unit::TestCase
  N = NAdicNumber::Base

  def setup
    @map_table = ["0".."9", "A".."Z", "a".."z"].map{|r| r.to_a}.flatten
    #@map_table = ("あ".."ん").to_a
    N.mapping @map_table
  end

  def test_zero
    assert_equal N.new(0).to_s, @map_table.first
    assert_equal N.new(@map_table.first).to_i, 0
  end

  def test_last
    assert_equal N.new(@map_table.size - 1).to_s, @map_table.last
    assert_equal N.new(@map_table.last).to_i, @map_table.size - 1
  end

  def test_border
    str = @map_table[0,2].reverse.join
    assert_equal N.new(@map_table.size).to_s, str
    assert_equal N.new(str).to_i, @map_table.size
  end

  def test_most_of_all
    base = [0, 2 ** 32]
    32.times do |base|
      pos = 2 ** base
      (pos..(pos + 10000)).each do |num|
        inst = N.new(num)
        int = inst.to_i
        assert_equal num, int
      end
    end
  end

  def test_add
    inst = N.new(100) + 50
    assert_equal 100 + 50, inst.to_i
  end

  def test_subtract
    inst = N.new(100) - 50
    assert_equal 100 - 50, inst.to_i
  end

  def test_multiply
    inst = N.new(100) * 50
    assert_equal 100 * 50, inst.to_i
  end

  def test_divide
    inst = N.new(100) / 50
    assert_equal 100 / 50, inst.to_i
  end
end
