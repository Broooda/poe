class Fifth

	def initialize(params)
		@cost = [[Cost.new(params[:c1]), Cost.new(params[:c2]), Cost.new(params[:c3]), Cost.new(params[:c4])],
						[Cost.new(params[:c5]), Cost.new(params[:c6]), Cost.new(params[:c7]), Cost.new(params[:c8])],
						[Cost.new(params[:c9]), Cost.new(params[:c10]), Cost.new(params[:c11]), Cost.new(params[:c12])]]
		@supply = [params[:s1], params[:s2], params[:s3]]
		@demand = [params[:d1], params[:d2], params[:d3], params[:d4]]
	end


	# def findMin(@cost)
	# 	min = 50;
	# 	retR = 0
	# 	retC = 0
	# 	(0..2).each do |r|
	# 		(0..3).each do |c|
	# 			if @cost[r][c] < min && @cost[r][c].convert == true
	# 				min = @cost[r][c]
	# 				retC = c
	# 				retR = r
	# 		end
	# 	end
	# 	return r,c
	# end

end