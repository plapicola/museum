class Museum

  attr_reader :name,
              :exhibits,
              :patrons,
              :revenue

  def initialize(name)
    @name = name
    @exhibits = []
    @patrons = []
    @revenue = 0
  end

  def add_exhibit(exhibit)
    @exhibits << exhibit
  end

  def admit(patron)
    @patrons << patron
    visit_exhibits(patron)
  end

  def visit_exhibits(patron)
    reccomend_exhibits_by_price(patron).each do |exhibit|
      if patron.spending_money >= exhibit.cost
        exhibit.recieve_patron(patron)
        @revenue += exhibit.cost
        patron.spend_money(exhibit.cost)
      end
    end
  end

  def reccomend_exhibits_by_price(patron)
    possible_exhibits = reccomend_exhibits(patron)
    possible_exhibits.sort_by do |exhibit|
      exhibit.cost
    end
    possible_exhibits.reverse
  end
  def reccomend_exhibits(patron)
    @exhibits.find_all do |exhibit|
      patron.interests.include?(exhibit.name)
    end
  end

  def interested_patrons(exhibit)
    @patrons.find_all do |patron|
      patron.interests.include?(exhibit.name)
    end
  end

  def patrons_by_exhibit_interest
    @exhibits.inject({}) do |found_patrons, exhibit|
      found_patrons[exhibit] = interested_patrons(exhibit)
      found_patrons
    end
  end

  def patrons_of_exhibits
    @exhibits.inject({}) do |patrons_by_exhibit, exhibit|
      patrons_by_exhibit[exhibit] = exhibit.patrons
      patrons_by_exhibit
    end
  end

end
