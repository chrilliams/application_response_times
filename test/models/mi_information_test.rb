require 'test_helper'

class MIInformationTest < ActiveSupport::TestCase
  # test "the truth" do
  #   assert true
  # end
  test "should create new MIInformation" do
    mi = MIInformation.new( '980190962', '04', '2014', '34', '0.2','2')
    assert_not_nil mi
    assert_instance_of MIInformation, mi
  end

  test "should_calculate_month_average" do
    mi = MIInformation.new( '980190962', '04', '2014', '34', '0.2','2')
    assert_not_nil mi
    assert_equal( 0.04, mi.month_average )
  end 
  
  test "should_calculate_month_max" do
    mi = MIInformation.new( '980190962', '04', '2014', '34', '0.2','2')
    assert_not_nil mi
    assert_equal( 0.06, mi.month_max )
  end 

  test "should_calculate_month_max2" do
    mi = MIInformation.new( '298486374', '04', '2014', '34', '0.2','2')
    assert_not_nil mi
    assert_equal( 0.06, mi.month_max )
  end 

  test "should_find_sundays" do
    mi = MIInformation.new( '980190962', '04', '2014', '34', '0.2','2')
    assert_equal( 4, mi.sundays_in_the_month.size )
  end 

  test "should_achieved" do
    mi = MIInformation.new( '980190962', '04', '2014', '34', 0.2,2)
    assert( mi.achieved? )
  end 
  test "should_not_achieved" do
    mi = MIInformation.new( '980190962', '04', '2014', '34', 200,0.01)
    assert_not( mi.achieved?)
  end 

  test "should_calculate_period_max" do
     mi = MIInformation.new( '298486374', '04', '2014', '34', 200,0.01)
     assert_equal( '', mi.period_max(1))
     assert_equal( '', mi.period_max(2))
     assert_equal( 0.06, mi.period_max(3))
     assert_equal( '', mi.period_max(4))
  end

  test "should_calculate_period_average" do
     mi = MIInformation.new( '298486374', '04', '2014', '34', 200,0.01)
     assert_equal( '', mi.period_average(1))
     assert_equal( '', mi.period_average(2))
     assert_equal( 0.06, mi.period_average(3))
     assert_equal( '', mi.period_average(4))
  end


end
