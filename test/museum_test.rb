require_relative 'test_helper'

class MuseumTest < Minitest::Test

  def setup
    @dmns = Museum.new("Denver Museum of Nature and Science")
    @gems_and_minerals = Exhibit.new("Gems and Minerals", 0)
    @dead_sea_scrolls = Exhibit.new("Dead Sea Scrolls", 10)
    @imax = Exhibit.new("IMAX", 15)
  end
  
  def test_it_exists
    assert_instance_of Museum, @dmns
  end

  def test_it_has_a_name
    assert_equal "Denver Museum of Nature and Science", @dmns.name
  end

  def test_it_has_no_patrons_by_default
    assert_equal [], @dmns.patrons
  end

  def test_it_has_no_exhibits_by_default
    assert_equal [], @dmns.exhibits
  end

  def test_it_has_revenue
    assert_equal 0, @dmns.revenue
  end

  def test_it_can_add_exhibits
    @dmns.add_exhibit(@gems_and_minerals)
    @dmns.add_exhibit(@dead_sea_scrolls)
    @dmns.add_exhibit(@imax)

    expected = [@gems_and_minerals, @dead_sea_scrolls, @imax]

    assert_equal expected, @dmns.exhibits
  end

  def test_it_can_reccomend_exhibits_based_on_patrons_interests
    bob = Patron.new("Bob", 20)
    bob.add_interest("Dead Sea Scrolls")
    bob.add_interest("Gems and Minerals")
    sally = Patron.new("Sally", 20)
    sally.add_interest("IMAX")
    @dmns.add_exhibit(@gems_and_minerals)
    @dmns.add_exhibit(@dead_sea_scrolls)
    @dmns.add_exhibit(@imax)

    bob_expected = [@gems_and_minerals, @dead_sea_scrolls]
    sally_expected = [@imax]

    assert_equal bob_expected, @dmns.reccomend_exhibits(bob)
    assert_equal sally_expected, @dmns.reccomend_exhibits(sally)
  end

  def test_it_can_admit_patrons
    bob = Patron.new("Bob", 20)
    sally = Patron.new("Sally", 20)

    @dmns.admit(bob)
    @dmns.admit(sally)

    assert_equal [bob, sally], @dmns.patrons
  end

  def test_it_can_display_patrons_interested_in_exhibits
    bob = Patron.new("Bob", 20)
    bob.add_interest("Dead Sea Scrolls")
    bob.add_interest("Gems and Minerals")
    sally = Patron.new("Sally", 20)
    sally.add_interest("Dead Sea Scrolls")
    @dmns.add_exhibit(@gems_and_minerals)
    @dmns.add_exhibit(@dead_sea_scrolls)
    @dmns.add_exhibit(@imax)
    @dmns.admit(bob)
    @dmns.admit(sally)

    expected = {
                @gems_and_minerals => [bob],
                @dead_sea_scrolls => [bob, sally],
                @imax => []
               }

    assert_equal expected, @dmns.patrons_by_exhibit_interest
  end

  def test_visitors_can_attend_exhibits
    tj = Patron.new("TJ", 7)
    tj.add_interest("IMAX")
    tj.add_interest("Dead Sea Scrolls")
    bob = Patron.new("Bob", 10)
    bob.add_interest("Dead Sea Scrolls")
    bob.add_interest("IMAX")
    sally = Patron.new("Sally", 20)
    sally.add_interest("IMAX")
    sally.add_interest("Dead Sea Scrolls")
    morgan = Patron.new("Morgan", 15)
    morgan.add_interest("Gems and Minerals")
    morgan.add_interest("Dead Sea Scrolls")
    @dmns.add_exhibit(@gems_and_minerals)
    @dmns.add_exhibit(@dead_sea_scrolls)
    @dmns.add_exhibit(@imax)
    @dmns.admit(tj)
    @dmns.admit(bob)
    @dmns.admit(sally)
    @dmns.admit(morgan)

    expected = {
                @dead_sea_scrolls => [bob, morgan],
                @imax => [sally],
                @gems_and_minerals => [morgan]
               }

    assert_equal expected, @dmns.patrons_of_exhibits
  end

  def test_it_can_collect_money_from_patrons_who_visit_exhibits
    tj = Patron.new("TJ", 7)
    tj.add_interest("IMAX")
    tj.add_interest("Dead Sea Scrolls")
    bob = Patron.new("Bob", 10)
    bob.add_interest("Dead Sea Scrolls")
    bob.add_interest("IMAX")
    sally = Patron.new("Sally", 20)
    sally.add_interest("IMAX")
    sally.add_interest("Dead Sea Scrolls")
    morgan = Patron.new("Morgan", 15)
    morgan.add_interest("Gems and Minerals")
    morgan.add_interest("Dead Sea Scrolls")
    @dmns.add_exhibit(@gems_and_minerals)
    @dmns.add_exhibit(@dead_sea_scrolls)
    @dmns.add_exhibit(@imax)
    @dmns.admit(tj)
    @dmns.admit(bob)
    @dmns.admit(sally)
    @dmns.admit(morgan)

    assert_equal 35, @dmns.revenue
  end

end
