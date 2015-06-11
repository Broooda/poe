class Fifth

	def initialize(params)
		@cost = [[Cost.new(params[:c1]), Cost.new(params[:c2]), Cost.new(params[:c3]), Cost.new(params[:c4])],
						[Cost.new(params[:c5]), Cost.new(params[:c6]), Cost.new(params[:c7]), Cost.new(params[:c8])],
						[Cost.new(params[:c9]), Cost.new(params[:c10]), Cost.new(params[:c11]), Cost.new(params[:c12])]]
		@supply = [params[:s1], params[:s2], params[:s3]]
		@demand = [params[:d1], params[:d2], params[:d3], params[:d4]]
		@matrix = [[], []]
	end

	def findMinCost(cost)
		min = 50;
		retR = 0
		retC = 0
		(0..2).each do |r|
			(0..3).each do |c|
				if cost[r][c] < min && cost[r][c].convert == true
					min = cost[r][c]
					retC = c
					retR = r
				end
			end
		end
		cost[retR][retC].convert = false
		return retR,retC
	end

	def conditionEnd(supply, demand)
		(0..2).each do |supp|
			if supply[supp] == 0
				suppCon = true
			end
		end
		(0..3).each do |dem|
			if demand[dem] == 0
				demandCon = true
			end
		end
		return true if demandCon == true && suppCon == true
		false
	end


	def calculate(matrix, supply, demand, cost)
		unless conditionEnd
			x = findMinCost(cost)
			r = x[0]
			c = x[1]

			#check row or column min 
			if demand[c] < supply[r]
				matrix[r][c] = demand[c]
			else 
				matrix[r][c] = supply[r]
			end

			#reduce demand and supply of value
			demand[c] -= matrix[r][c]
			supply[r] -= matrix[r][c]

			#complete rest column/row to zero if supply/demand equal to zero
			if demnad[c] == 0
				0..2.each do |ir|
					if cost[ir][c].convert == true
						matrix[ir][c] = 0
						cost[ir][c].convert = false
					end
				end
			end
			if supply[c] == 0
				(0..3).each do |ic|
					if cost[r][ic].convert == true
						matrix[r][ic] = 0
						cost[r][ic].convert = false
					end
				end
			end
		end
	end
end
