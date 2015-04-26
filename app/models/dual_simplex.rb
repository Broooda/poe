class DualSimplex < ActiveRecord::Base

  def self.uzupelnij(params)
    sympleks_tab=[[],[],[],[],[],[],[]]
        
    sympleks_tab[0][0]=''
    sympleks_tab[0][1]=''
    sympleks_tab[0][2]='cj'
    sympleks_tab[0][3]=params[:zx1].to_f
    sympleks_tab[0][4]=params[:zx2].to_f
    sympleks_tab[0][5]=params[:zx3].to_f
    sympleks_tab[0][6]=params[:zx4].to_f
    sympleks_tab[0][7]=params[:zx5].to_f
    sympleks_tab[0][8]=0.0
    sympleks_tab[0][9]=0.0
    sympleks_tab[0][10]=0.0

    sympleks_tab[1][0]='cb'
    sympleks_tab[1][1]='yb'
    sympleks_tab[1][2]='xb'
    sympleks_tab[1][3]='y1'
    sympleks_tab[1][4]='y2'
    sympleks_tab[1][5]='y3'
    sympleks_tab[1][6]='y4'
    sympleks_tab[1][7]='y5'
    sympleks_tab[1][8]='y6'
    sympleks_tab[1][9]='y7'
    sympleks_tab[1][10]='y8'

    sympleks_tab[2][0]=0.0
    sympleks_tab[2][1]='y6'
    sympleks_tab[2][2]=-params[:ay].to_f
    sympleks_tab[2][3]=-params[:ax1].to_f
    sympleks_tab[2][4]=-params[:ax2].to_f
    sympleks_tab[2][5]=-params[:ax3].to_f
    sympleks_tab[2][6]=-params[:ax4].to_f
    sympleks_tab[2][7]=-params[:ax5].to_f
    sympleks_tab[2][8]=1.0
    sympleks_tab[2][9]=0.0
    sympleks_tab[2][10]=0.0

    sympleks_tab[3][0]=0.0
    sympleks_tab[3][1]='y7'
    sympleks_tab[3][2]=-params[:by].to_f
    sympleks_tab[3][3]=-params[:bx1].to_f
    sympleks_tab[3][4]=-params[:bx2].to_f
    sympleks_tab[3][5]=-params[:bx3].to_f
    sympleks_tab[3][6]=-params[:bx4].to_f
    sympleks_tab[3][7]=-params[:bx5].to_f
    sympleks_tab[3][8]=0.0
    sympleks_tab[3][9]=1.0
    sympleks_tab[3][10]=0.0

    sympleks_tab[4][0]=0.0
    sympleks_tab[4][1]='y8'
    sympleks_tab[4][2]=-params[:cy].to_f
    sympleks_tab[4][3]=-params[:cx1].to_f
    sympleks_tab[4][4]=-params[:cx2].to_f
    sympleks_tab[4][5]=-params[:cx3].to_f
    sympleks_tab[4][6]=-params[:cx4].to_f
    sympleks_tab[4][7]=-params[:cx5].to_f
    sympleks_tab[4][8]=0.0
    sympleks_tab[4][9]=0.0
    sympleks_tab[4][10]=1.0

    sympleks_tab[5][0]=''
    sympleks_tab[5][1]=''
    sympleks_tab[5][2]='zj'
    sympleks_tab[5][3]=0.0
    sympleks_tab[5][4]=0.0
    sympleks_tab[5][5]=0.0
    sympleks_tab[5][6]=0.0
    sympleks_tab[5][7]=0.0
    sympleks_tab[5][8]=0.0
    sympleks_tab[5][9]=0.0
    sympleks_tab[5][10]=0.0

    sympleks_tab[6][0]=''
    sympleks_tab[6][1]=''
    sympleks_tab[6][2]='zj-cj'
    sympleks_tab[6][3]=-params[:zx1].to_f
    sympleks_tab[6][4]=-params[:zx2].to_f
    sympleks_tab[6][5]=-params[:zx3].to_f
    sympleks_tab[6][6]=-params[:zx4].to_f
    sympleks_tab[6][7]=-params[:zx5].to_f
    sympleks_tab[6][8]=0.0
    sympleks_tab[6][9]=0.0
    sympleks_tab[6][10]=0.0

    return {sympleks_tab: sympleks_tab}
  end

  #index_of_min_xb_less_than_zero   patrzymy na PION
  def self.find_exit_criteria(sympleks_tab)
    min = 999.0
    index = nil
    (2..4).each do |j|
        if sympleks_tab[j][2] < min
            min = sympleks_tab[2][j]
            index = j
        end
    end
    return index
  end

  #index_of_max_zj_minus_cj_less_than_zero patrzymy na POZIOM
  def self.find_enter_criteria(sympleks_tab)
    min = 999.0
    index = nil
    (3..10).each do |j|
        if (sympleks_tab[6][j]/sympleks_tab[find_exit_criteria(sympleks_tab)][j]).abs < min && (sympleks_tab[6][j]/sympleks_tab[find_exit_criteria(sympleks_tab)][j]).abs!=0.0
            min = (sympleks_tab[6][j] / sympleks_tab[find_exit_criteria(sympleks_tab)][j]).abs
            index = j
        end
    end
    return index
  end

  def self.transformation_to_one_in_cell(sympleks_tab)
    @x=find_enter_criteria(sympleks_tab)
    @y=find_exit_criteria(sympleks_tab)
   
   sympleks_tab[@y][0]=sympleks_tab[0][@x]
   sympleks_tab[@y][1]=sympleks_tab[1][@x]

    divider=sympleks_tab[@y][@x]
    (2..10).each do |j|
        sympleks_tab[@y][j]=sympleks_tab[@y][j]/divider
    end
    return sympleks_tab
  end

  def self.transformation_other_to_zero(sympleks_tab)
    #x=find_enter_criteria(sympleks_tab)
    #y=find_exit_criteria(sympleks_tab)
    (2..4).each do |i|
        multiplier=(sympleks_tab[i][@x])*(-1)
         (2..10).each do |j|
             sympleks_tab[i][j]=sympleks_tab[i][j]+(sympleks_tab[@y][j]*multiplier) if i!=@y
         end
    end
    return sympleks_tab
  end

#brak testow
  def self.calculate_zj(sympleks_tab)
    (3..10).each do |i|
        result=0.0
        (2..4).each do |j|
            result=result+sympleks_tab[j][0]*sympleks_tab[j][i]
        end
        sympleks_tab[5][i]=result
    end
    return sympleks_tab
  end

#brak testow
  def self.calculate_zj_minus_cj(sympleks_tab)
    (3..10).each do |j|
        sympleks_tab[6][j]= sympleks_tab[5][j]-sympleks_tab[0][j]
    end
    return sympleks_tab
  end

#brak testow
  def self.check_if_optimum(sympleks_tab)
    (3..10).each do |j|
        return false if sympleks_tab[6][j] > 0.0
    end
  true
  end

#brak testow
  def self.check_if_feasible(sympleks_tab)
    (2..4).each do |j|
       return false if sympleks_tab[j][2] < 0.0
    end
  true
  end


  def self.all_in(sympleks_tab)
    # puts check_if_optimum(sympleks_tab)
    # puts'--------'
    # puts check_if_feasible(sympleks_tab)
    # puts 'haha'
    # puts !(check_if_optimum(sympleks_tab) && check_if_feasible(sympleks_tab))
    while !(check_if_optimum(sympleks_tab) && check_if_feasible(sympleks_tab)) do 
      #binding.pry
      transformation_to_one_in_cell(sympleks_tab)
      transformation_other_to_zero(sympleks_tab)
      calculate_zj(sympleks_tab)
      calculate_zj_minus_cj(sympleks_tab)
      puts 'petla'
    end
    #binding.pry
    return sympleks_tab
  end

end
