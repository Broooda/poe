class FourSimplex < ActiveRecord::Base


  def self.symbolToTable(what)
    if what == ">="
      return -1
    end
    if what == "<="
      return 1
    end
    return nil
  end

  def self.uzupelnij(params)
    sympleks_tab=[[],[],[],[],[],[],[], [], [], []]
        
    sympleks_tab[0][0]=''
    sympleks_tab[0][1]=''
    sympleks_tab[0][2]='licznik'
    sympleks_tab[0][3]=params[:zx3].to_f
    sympleks_tab[0][4]=params[:zx1].to_f
    sympleks_tab[0][5]=params[:zx2].to_f
    sympleks_tab[0][6]=0.0
    sympleks_tab[0][7]=0.0
    sympleks_tab[0][8]=0.0
    sympleks_tab[0][9]=0.0

    sympleks_tab[1][0]=''
    sympleks_tab[1][1]=''
    sympleks_tab[1][2]='mianownik'
    sympleks_tab[1][3]=params[:yx3].to_f
    sympleks_tab[1][4]=params[:yx1].to_f
    sympleks_tab[1][5]=params[:yx2].to_f
    sympleks_tab[1][6]=0.0
    sympleks_tab[1][7]=0.0
    sympleks_tab[1][8]=0.0
    sympleks_tab[1][9]=0.0

    sympleks_tab[2][0]='cB'
    sympleks_tab[2][1]='dB'
    sympleks_tab[2][2]='baza'
    sympleks_tab[2][3]='xB'
    sympleks_tab[2][4]='p1'
    sympleks_tab[2][5]='p2'
    sympleks_tab[2][6]='p3'
    sympleks_tab[2][7]='p4'
    sympleks_tab[2][8]='p5'
    sympleks_tab[2][9]='p6'

    sympleks_tab[3][0]=0.0
    sympleks_tab[3][1]=0.0
    sympleks_tab[3][2]='p3'
    sympleks_tab[3][3]=params[:ax3].to_f
    sympleks_tab[3][4]=params[:ax1].to_f
    sympleks_tab[3][5]=params[:ax2].to_f
    sympleks_tab[3][6]=symbolToTable(params[:a_symbol])
    sympleks_tab[3][7]=0.0
    sympleks_tab[3][8]=0.0
    sympleks_tab[3][9]=0.0

    sympleks_tab[4][0]=0.0
    sympleks_tab[4][1]=0.0
    sympleks_tab[4][2]='p4'
    sympleks_tab[4][3]=params[:bx3].to_f
    sympleks_tab[4][4]=params[:bx1].to_f
    sympleks_tab[4][5]=params[:bx2].to_f
    sympleks_tab[4][6]=0.0
    sympleks_tab[4][7]=symbolToTable(params[:b_symbol])
    sympleks_tab[4][8]=0.0
    sympleks_tab[4][9]=0.0

    sympleks_tab[5][0]=0.0
    sympleks_tab[5][1]=0.0
    sympleks_tab[5][2]='p5'
    sympleks_tab[5][3]=params[:cx3].to_f
    sympleks_tab[5][4]=params[:cx1].to_f
    sympleks_tab[5][5]=params[:cx2].to_f
    sympleks_tab[5][6]=0.0
    sympleks_tab[5][7]=0.0
    sympleks_tab[5][8]=symbolToTable(params[:c_symbol])
    sympleks_tab[5][9]=0.0

    sympleks_tab[6][0]=0.0
    sympleks_tab[6][1]=0.0
    sympleks_tab[6][2]='p6'
    sympleks_tab[6][3]=params[:dx3].to_f
    sympleks_tab[6][4]=params[:dx1].to_f
    sympleks_tab[6][5]=params[:dx2].to_f
    sympleks_tab[6][6]=0.0
    sympleks_tab[6][7]=0.0
    sympleks_tab[6][8]=0.0
    sympleks_tab[6][9]=symbolToTable(params[:d_symbol])

    sympleks_tab[7][0]=''
    sympleks_tab[7][1]='delta'
    sympleks_tab[7][2]='L'
    calculate_l(sympleks_tab)
    # sympleks_tab[7][3]=POLICZL()
    # sympleks_tab[7][4]=POLICZL()
    # sympleks_tab[7][5]=POLICZL()
    # sympleks_tab[7][6]=0.0
    # sympleks_tab[7][7]=0.0
    # sympleks_tab[7][8]=0.0
    # sympleks_tab[7][9]=0.0

    sympleks_tab[8][0]=''
    sympleks_tab[8][1]='delta'
    sympleks_tab[8][2]='M'
    calculate_m(sympleks_tab)
    # sympleks_tab[8][3]=POLICZM()
    # sympleks_tab[8][4]=POLICZM()
    # sympleks_tab[8][5]=POLICZM()
    # sympleks_tab[8][6]=0.0
    # sympleks_tab[8][7]=0.0
    # sympleks_tab[8][8]=0.0
    # sympleks_tab[8][9]=0.0

    sympleks_tab[9][0]=''
    sympleks_tab[9][1]='delta'
    sympleks_tab[9][2]='B'
    calculate_b(sympleks_tab)
    # sympleks_tab[9][3]=POLICZB()
    # sympleks_tab[9][4]=POLICZB()
    # sympleks_tab[9][5]=POLICZB()
    # sympleks_tab[9][6]=0.0
    # sympleks_tab[9][7]=0.0
    # sympleks_tab[9][8]=0.0
    # sympleks_tab[9][9]=0.0

    return {sympleks_tab: sympleks_tab}
  end

  def self.calculate_l(sympleks_tab)
    (3..9).each do |i|
      sympleks_tab[7][i] = 0.0
      (3..6).each do |j|
        sympleks_tab[7][i] += sympleks_tab[j][i]*sympleks_tab[j][1]
      end

      if i == 3
        sympleks_tab[7][i] += sympleks_tab[0][i]
      elsif 
        sympleks_tab[7][i] -= sympleks_tab[0][i]
      end
    end
  end

  def self.calculate_m(sympleks_tab)
    (3..9).each do |i|
      sympleks_tab[8][i] = 0.0
      (3..6).each do |j|
        sympleks_tab[8][i] += sympleks_tab[j][i]*sympleks_tab[j][1]
      end
      if i == 3
        sympleks_tab[8][i] += sympleks_tab[1][i]
      elsif    
        sympleks_tab[8][i] -= sympleks_tab[1][i]
      end
    end
  end

  def self.calculate_b(sympleks_tab)
    sympleks_tab[9][3] = sympleks_tab[7][3]/sympleks_tab[8][3]
    (4..9).each do |i|
      sympleks_tab[9][i]=sympleks_tab[7][3]*sympleks_tab[8][i]-(sympleks_tab[8][3]*sympleks_tab[7][i])
    end
  end


  #index_of_min_theta_greater_than_zero   patrzymy na PION
  def self.find_exit_criteria(sympleks_tab, x)
    puts "exit poczatek"
    min = 999.0
    indexExit = nil
    (3..6).each do |j|
      puts "-----------------------"
      puts sympleks_tab[j][3]
      puts "/"
      puts sympleks_tab[3][x]
      puts min
      puts "-----------------------"
      puts "x:"
      puts x
      if sympleks_tab[j][3]/sympleks_tab[3][x] < min && sympleks_tab[j][3]/sympleks_tab[3][x]>0.0 && sympleks_tab[j][3] != 0.0
        puts "min=" 
        puts sympleks_tab[j][3]
        puts "przez"
        puts sympleks_tab[3][x]
        min = sympleks_tab[j][3]/sympleks_tab[3][x]
        indexExit = j
        puts "j:"
        puts j
      end
      # else
      #   raise StandardError
      # end
      puts "exit srodek"
    end
    #raise StandardError if !indexExit   
    return indexExit
  end

  #index_of_max_delta_b_greater_than_zero   patrzymy na POZIOM
  def self.find_enter_criteria(sympleks_tab)
    puts "enter start"
     max = 0.0
     index = nil
     (4..9).each do |i|
        if sympleks_tab[9][i] > max
          max = sympleks_tab[9][i]
          index = i
        end
      end
      puts "enter srodek"
    raise StandardError if !index 
    puts "enter koniec"
    return index
  end

  def self.transformation_to_one_in_cell(sympleks_tab)
    x = find_enter_criteria(sympleks_tab)
    puts "x: #{x}"
    y = find_exit_criteria(sympleks_tab, x)
    puts "y: #{y}"
   
    sympleks_tab[y][2] = sympleks_tab[2][x]
    sympleks_tab[y][0] = sympleks_tab[0][x]
    sympleks_tab[y][1] = sympleks_tab[1][x]

    divider=sympleks_tab[y][x]
    (3..9).each do |j|
      sympleks_tab[y][j]=sympleks_tab[y][j]/divider
    end
    {sympleks_tab: sympleks_tab, x: x, y: y}
  end

  def self.transformation_other_to_zero(sympleks_tab, x, y)
    (3..9).each do |i|
      multiplier=(sympleks_tab[i][x])*(-1)
     (3..9).each do |j|
        sympleks_tab[i][j]=sympleks_tab[i][j]+(sympleks_tab[y][j]*multiplier) if i!=y
      end
    end
    return sympleks_tab
  end

  def self.check_if_optimum(sympleks_tab)
    (4..9).each do |j|
      #return false if sympleks_tab[9][j] > 0.0
    end
    true
  end

  def self.all_in(sympleks_tab)
  puts "------------------"
  puts "all in"
  puts "------------------"
    step_by_step = []
    (0..9).each do |c|
    #calculate_m(sympleks_tab)
    #calculate_l(sympleks_tab)
    #calculate_b(sympleks_tab)
    puts "------------------"
    puts c
    puts "------------------"
      result = transformation_to_one_in_cell(sympleks_tab)
    puts "------------------"
    puts "za transformation_to_one_in_cell"
    puts result
    puts "------------------"
      x = result[:x]
      y = result[:y]
      sympleks_tab = result[:sympleks_tab]
      sympleks_tab = transformation_other_to_zero(sympleks_tab, x,y)
      calculate_b(sympleks_tab)
    puts "------------------"
    puts "za transformation_other_to_zero"
    puts sympleks_tab.inspect
    puts "------------------"
      #sympleks_tab = calculate_zj(sympleks_tab)
      #sympleks_tab = calculate_zj_minus_cj(sympleks_tab)
      step_by_step[c] = [sympleks_tab[0].clone,sympleks_tab[1].clone,sympleks_tab[2].clone,sympleks_tab[3].clone,sympleks_tab[4].clone,sympleks_tab[5].clone,sympleks_tab[6].clone,sympleks_tab[7].clone,sympleks_tab[8].clone,sympleks_tab[9].clone]
    puts "------------------"
    puts "warunek"
    puts check_if_optimum(sympleks_tab)
    puts "------------------"
      return {sympleks_tab: sympleks_tab, step_by_step: step_by_step, success: true} if check_if_optimum(sympleks_tab)
    end
  puts "------------------"
  puts "koniec"
  puts "------------------"
    {sympleks_tab: sympleks_tab, step_by_step: step_by_step, success: false}
  end

  # def self.calculate_result(sympleks_tab)
  #   result=0.0
  #   (2..4).each do |j|
  #     index_y=sympleks_tab[j][1][1].to_f
  #     index_y+=2
  #     puts "indeks: #{index_y}"
  #     result+=sympleks_tab[0][index_y]*sympleks_tab[j][2]
  #     puts "wynik posredni: #{result}"
  #   end
  #   puts "--------------"
  #   puts "wynik ostateczny: #{result}"
  #   return result
  # end
end
