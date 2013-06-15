require 'minitest/autorun'
require '../lib/takeaway'
require 'mocha/setup'


class ImageTest < MiniTest::Unit::TestCase

  def setup
    @takeaway = Takeaway.new
  end

  def test_the_total_ammount_of_a_request_is_calculated
    assert_equal 33, @takeaway.request({:lasagne => 3, :fishpie => 10})
  end

  def test_confirm_order_when_correct_comparison
    @takeaway.stubs(:send!).returns(true)
    assert_equal @takeaway.confirm_order, @takeaway.compare(33, 33)
  end

  def test_error_message_when_wrong_comparison
    assert_raises(RuntimeError) do
      assert_equal "It is a wrong estimate", @takeaway.compare(30, 33)
    end
  end

  def test_send_message_for_confirmation
    @takeaway.stubs(:send!).returns(true)
    assert_equal @takeaway.send!, @takeaway.compare(33, 33)
  end

end

