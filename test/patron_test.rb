require_relative 'test_helper'

class PatronTest < Minitest::Test

  def setup
    @bob = Patron.new("Bob", 20)
  end

  def test_it_exists
    assert_instance_of Patron, @bob
  end

  def test_it_has_a_name
    assert_equal "Bob", @bob.name
  end

  def test_it_has_spending_money
    assert_equal 20, @bob.spending_money
  end

  def test_it_has_no_interests_by_default
    assert_equal [], @bob.interests
  end

  def test_it_can_add_new_interests
    @bob.add_interest("Dead Sea Scrolls")
    @bob.add_interest("Gems and Minerals")

    assert_equal ["Dead Sea Scrolls", "Gems and Minerals"], @bob.interests
  end

  def test_it_can_spend_money
    @bob.spend_money(10)

    assert_equal 10, @bob.spending_money
  end

end
