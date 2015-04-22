class DualSimplex < ActiveRecord::Base

  def self.uzupelnij(params)
    z = []
    first = [[],[]]
    second = [[],[]]
    third = [[],[]]

    z[0] = params[:zx1].to_f
    z[1] = params[:zx2].to_f
    z[2] = params[:zx3].to_f
    z[3] = params[:zx4].to_f
    z[4] = params[:zx5].to_f

    first[0][0] = params[:ax1].to_f
    first[0][1] = params[:ax2].to_f
    first[0][2] = params[:ax3].to_f
    first[0][3] = params[:ax4].to_f
    first[0][4] = params[:ax5].to_f
    first[1][0] = params[:ay].to_f

    second[0][0] = params[:bx1].to_f
    second[0][1] = params[:bx2].to_f
    second[0][2] = params[:bx3].to_f
    second[0][3] = params[:bx4].to_f
    second[0][4] = params[:bx5].to_f
    second[1][0] = params[:by].to_f

    third[0][0] = params[:cx1].to_f
    third[0][1] = params[:cx2].to_f
    third[0][2] = params[:cx3].to_f
    third[0][3] = params[:cx4].to_f
    third[0][4] = params[:cx5].to_f
    third[1][0] = params[:cy].to_f

    return {z: z, first: first, second: second, third: third}
  end

end