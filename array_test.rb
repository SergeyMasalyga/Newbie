require 'test_helper'

class ArrayTest < EdgeCase::TestCase

  def test_basic_arrays
    food = [:peanut, :button, :and, :jelly]
    assert_equal :peanut, food[0]
    assert_equal 4, food.size
  end

  def test_array_access
    food = [:peanut, :button, :and, :jelly]
    assert_equal :peanut, food.first
    assert_equal :jelly, food.last
    assert_equal :peanut, food[0]
    assert_equal :and, food[2]
    assert_equal :jelly, food[(food.size() - 1)]
  end

  def test_arrays_with_other_objects
    food = [:peanut, :button, :and, :jelly, 1, nil]
    assert_equal 6, food.size
    assert_equal nil, food.last
    assert_equal nil, food[5]
  end

  def test_adding_to_an_array_with_shovel_shovel
    food = [:peanut, :button, :and, :jelly]
    food << 'sandwich'
    assert_equal 5, food.size
    assert_equal :peanut, food.first
  end

  def test_adding_to_an_array_with_push
    food = [:peanut, :button, :and, :jelly]
    food.push('sandwich')
    assert_equal "sandwich", food.last
  end

  def test_adding_to_an_array_with_unshift
    food = [:peanut, :button, :and, :jelly]
    food.unshift('a')
    assert_equal "a", food.first
  end

end

