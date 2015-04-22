class FirstTasksController < ApplicationController
  def data; end

  def calculation
    @params = params
    hash = Simplex.uzupelnij(params)
    @base_matrix = hash[:base]
    @gain_array = hash[:gain]
    @time_array = hash[:time]
    @result = [0,0,0,0,0,0]
    @cb_array = [0,0,0]
    @cb_array_x = ['x4','x5','x6']
    przejscie = 1

    (0..@base_matrix[0].size-1).each do |j|
      (0..@base_matrix.size-1).each do |i|
        @result[j] += @cb_array[i] * @base_matrix[i][j]
      end
       @result[j] = @result[j] - @gain_array[j]
    end

    puts ''
    puts ''
    puts 0
    puts 'wspolczynniki'
    puts @base_matrix[0].inspect
    puts @base_matrix[1].inspect
    puts @base_matrix[2].inspect
    puts @result.inspect
    puts ''
    puts 'Baza:'
    puts @cb_array_x.inspect
    puts 'cb:'
    puts @cb_array.inspect
    puts 'b'
    puts @time_array.inspect

    flag = true
      while flag do
        wyjscia = Simplex.kryterium_wyjscia(@result, @cb_array,@base_matrix,@gain_array)
        wyjscia_x = wyjscia[0]
        wyjscia_y = wyjscia[1]

        if wyjscia_x.nil? or wyjscia_y.nil?
          if wyjscia_x.nil?
            @zmienna = 0
            flash[:alert] = ' rozwiązanie optymalne ' 
            (0..@cb_array.size-1).each do |i|
              @zmienna += @cb_array[i] * @time_array[i]
            end

            puts ''
            puts ''
            puts przejscie
            puts 'wspolczynniki'
            puts @base_matrix[0].inspect
            puts @base_matrix[1].inspect
            puts @base_matrix[2].inspect
            puts @result.inspect
            puts ''
            puts 'Baza:'
            puts @cb_array_x.inspect
            puts 'cb:'
            puts @cb_array.inspect
            puts 'b'
            puts @time_array.inspect
            przejscie+=1
            puts 'rozwiazanie'
            puts @zmienna
          else
            flash[:alert] = ' rozwiązanie sprzeczne '
          end
          return render :result
        end

        dzielnik = @base_matrix[wyjscia_y][wyjscia_x]
        (0..@base_matrix[0].size-1).each do |i|
          @base_matrix[wyjscia_y][i] = @base_matrix[wyjscia_y][i] / dzielnik
        end
          @time_array[wyjscia_y] = @time_array[wyjscia_y] / dzielnik

        (0..@base_matrix.size-1).each do |i|
          if i != wyjscia_y
            wsp = @base_matrix[i][wyjscia_x]/@base_matrix[wyjscia_y][wyjscia_x]
            (0..@base_matrix[0].size-1).each do |j|
              @base_matrix[i][j] = @base_matrix[i][j] - @base_matrix[wyjscia_y][j] * wsp
            end
            @time_array[i] = @time_array[i] - @time_array[wyjscia_y] * wsp
          end
        end
        wsp = @result[wyjscia_x]/@base_matrix[wyjscia_y][wyjscia_x]
        (0..@base_matrix[0].size-1).each do |j|
          @result[j] = @result[j] - @base_matrix[wyjscia_y][j] * wsp
        end
        @cb_array[wyjscia_y] = @gain_array[wyjscia_x]
        @cb_array_x[wyjscia_y] = "x#{wyjscia_x+1}"

        puts ''
        puts ''
        puts przejscie
        puts 'wspolczynniki'
        puts @base_matrix[0].inspect
        puts @base_matrix[1].inspect
        puts @base_matrix[2].inspect
        puts @result.inspect
        puts ''
        puts 'Baza:'
        puts @cb_array_x.inspect
        puts 'cb:'
        puts @cb_array.inspect
        puts 'b'
        puts @time_array.inspect
        przejscie+=1
      end

    render :result
  end

  def result

  end
end