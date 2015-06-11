class Cost
	attr_accessor :cost, :convert

	def initialize(cost)
		@cost = cost.to_i
		@convert = true
	end

  def inspect
    @cost
  end

end