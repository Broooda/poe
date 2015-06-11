class Cost
	attr_accessor :cost, :convert

	def initialize(cost)
		@cost = cost
		@convert = true
	end

  def inspect
    @cost
  end

end