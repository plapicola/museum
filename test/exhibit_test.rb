require_relative 'test_helper'

class ExhibitTest < Minitest::Test

  def setup
    @exhibit = Exhibit.new("Gems and Minerals", 0)
  end

  def test_it_exists
    assert_instance_of Exhibit, @exhibit
  end

  def test_it_has_a_name
    assert_equal "Gems and Minerals", @exhibit.name
  end

  def test_it_has_a_cost
    assert_equal 0, @exhibit.cost
  end

  def test_it_has_a_list_of_patrons
    assert_equal [], @exhibit.patrons
  end

  def test_it_can_be_visited_by_patrons
    bob = Patron.new("Bob", 20)
    bob.add_interest("Gems and Minerals")

    @exhibit.recieve_patron(bob)

    assert_equal [bob], @exhibit.patrons
  end

end
