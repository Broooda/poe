class Simplex < ActiveRecord::Base

  def self.uzupelnij(params)
    @gain_array = []
    @time_array = [] 
    @base_matrix = [[],[],[]]


    @time_array[0] = params[:a1].to_f
    @time_array[1] = params[:a2].to_f
    @time_array[2] = params[:a3].to_f

    @gain_array[0] = -(params[:gain1].to_f)
    @gain_array[1] = -(params[:gain2].to_f)
    @gain_array[2] = -(params[:gain3].to_f)
    @gain_array[3] = 0.0
    @gain_array[4] = 0.0
    @gain_array[5] = 0.0
  
    @base_matrix[0][0] = params[:x1].to_f
    @base_matrix[0][1] = params[:y1].to_f
    @base_matrix[0][2] = params[:z1].to_f
    @base_matrix[0][3] = 1.0    
    @base_matrix[0][4] = 0.0
    @base_matrix[0][5] = 0.0

    @base_matrix[1][0] = params[:x2].to_f
    @base_matrix[1][1] = params[:y2].to_f
    @base_matrix[1][2] = params[:z2].to_f
    @base_matrix[1][3] = 0.0 
    @base_matrix[1][4] = 1.0
    @base_matrix[1][5] = 0.0

    @base_matrix[2][0] = params[:x3].to_f
    @base_matrix[2][1] = params[:y3].to_f
    @base_matrix[2][2] = params[:z3].to_f
    @base_matrix[2][3] = 0.0
    @base_matrix[2][4] = 0.0
    @base_matrix[2][5] = 1.0

    return {gain: @gain_array, time: @time_array, base: @base_matrix}
  end

  def self.kryterium_wyjscia(result, cb_array,base_matrix,gain_array)
    min_index_x = Simplex.find_biggest_greater_than_zero(result)
    return [nil, 1] if min_index_x.nil?
    temporary = [0,0,0]
    (0..base_matrix.size-1).each do |j|
      temporary[j] = @time_array[j] / base_matrix[j][min_index_x] if base_matrix[j][min_index_x] != 0
    end
    min_index_y =  Simplex.find_smallest_greater_than_zero(temporary)
    return [1, nil] if min_index_x.nil?
    return [min_index_x, min_index_y]
  end

  def self.find_smallest_greater_than_zero(array)
    base = array
    base_without_zero = base
    base_without_zero -= [0]
    base_without_zero -= [0.0]
    (0..array.size).each do |i|
      return nil if base_without_zero.size == 0
      return base.index(base_without_zero.min) if base_without_zero.min > 0
      base_without_zero -= [base_without_zero.min]
    end
  end

  def self.find_biggest_greater_than_zero(array)
    (0..array.size).each do |i|
      return array.index(array.max) if array.max > 0
      return nil
    end
  end
end