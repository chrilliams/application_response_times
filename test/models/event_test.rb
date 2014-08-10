require 'test_helper'

class EventTest < ActiveSupport::TestCase
  # test "the truth" do
  #   assert true
  # end
  test "should_find_3_events" do
    assert_equal( 3, Event.all_during_year_and_month('2014/04').count )
  end

  test "should_find_0_events" do
    assert_equal( 0, Event.all_during_year_and_month('2014/05').count )
  end

  test "should_find_events_between_dates" do
    assert_equal( 1, Event.all_between_dates('2014-04-07', '2014-04-09').count, 'check between 2014-04-07 and 2014-04-09' )
    assert_equal( 0, Event.all_between_dates('2014-04-19', '2014-04-21').count, 'check between 2014-04-19 and 2014-04-21' )
    assert_equal( 2, Event.all_between_dates('2014-04-18', '2014-04-21').count, 'check between 2014-04-18 and 2014-04-21' )
    assert_equal( 3, Event.all_between_dates('2014-04-01', '2014-04-30').count, 'check between 2014-04-01 and 2014-04-30' )
  end

  test "should_find_unique_dates" do
    assert_equal( ['2014/04'], Event.unique_dates)
  end

  test "shold_find_unique_business_service" do
    assert_equal( 2, Event.unique_business_service('2014/04').size)
  end
end
