class Exhibit

  attr_reader :name,
              :cost,
              :patrons

  def initialize(name, cost)
    @name = name
    @cost = cost
    @patrons = []
  end

  def recieve_patron(patron)
    @patrons << patron
  end


end
