class Fifth < ActiveRecord::Base



 @cost = [[Cost.new(3), Cost.new(4), Cost.new(7), Cost.new(1)],
					[Cost.new(5), Cost.new(1), Cost.new(3), Cost.new(4)],
					[Cost.new(2), Cost.new(4), Cost.new(5), Cost.new(2)]]
	@supply=[100, 150, 100]
	@demand=[80, 120, 120, 30]


	def findMin(@cost)
		min = 50;
		retR = 0
		retC = 0
		(0..2).each do |r|
			(0..3).each do |c|
				if @cost[r][c] < min && @cost[r][c].convert == true
					min = @cost[r][c]
					retC = c
					retR = r
			end
		end
		return r,c
	end

end